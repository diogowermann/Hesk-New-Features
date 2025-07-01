<?php
/**
 *
 * This file is NOT part of HESK - PHP Help Desk Software.
 *
 * (c) Copyright Klemen Stirn. All rights reserved to the owner of the software.
 * https://www.hesk.com
 *
 * For the full copyright and license agreement information visit
 * https://www.hesk.com/eula.php
 *
 * This file does not claim ownership for the software.
 */
define('IN_SCRIPT', 1);
define('HESK_PATH', '../');
define('IS_ASSET', 1);

require(HESK_PATH . 'hesk_settings.inc.php');
require(HESK_PATH . 'inc/common.inc.php');
require(HESK_PATH . 'inc/admin_functions.inc.php');
require(HESK_PATH . 'inc/database_mysqli.inc.php');
hesk_load_database_functions();

hesk_session_start();
hesk_dbConnect();
hesk_isLoggedIn();
hesk_checkPermission('can_man_assets');

// table prefix
$dbp = hesk_dbEscape($hesk_settings['db_pfix']) . 'computers_';

// Get ID from URL to know if we're editing
$id  = intval(hesk_GET('id', 0));
$editing  = $id > 0;
// Get type to know wich form to display
$type = hesk_GET('type', '');
$types = array(
    'cpu'         => 'cpu',
    'ram'         => 'ram',
    'motherboard' => 'mb',
    'font'        => 'ps',
    'disk'        => 'disk'
); 
$type = $types[$type];

// Prepare default values
$default_values = [];
switch ($type) {
    case 'cpu':
        $default_values = [
            'id'      => '',
            'model'   => '',
            'cores'   => '',
            'threads' => '',
        ];
    case 'disk':
        $default_values = [
            'id'          => '',
            'model'       => '',
            'disk_type'   => '',
            'interface'   => '',
            'speed_rpm'   => '',
            'capacity_gb' => '',
        ];
    case 'motherboard':
        $default_values = [
            'id'                 => '',
            'model'              => '',
            'ram_slots'          => '',
            'ram_max_storage'    => '',
            'ram_type'           => '',
            'ram_max_storage_gb' => '',
            'ram_max_speed_mhz'  => '',
            'chipset'            => '',
            'network_iface'      => '',
            'usb_ports'          => '',
            'video_ports'        => '',
            'storage_ifaces'     => '',
        ];
    case 'psu':
        $default_values = [
            'id'        => '',
            'model'     => '',
            'wattage_w' => '',
            'is_bivolt' => 0,
        ];
    case 'ram':
        $default_values = [
            'id'        => '',
            'model'     => '',
            'size_gb'   => '',
            'speed_mhz' => '',
            'ram_type'  => '',
        ];
}

// If editing, load existing component
if ($editing) {
    $res = hesk_dbQuery("
        SELECT * 
        FROM `{$dbp}{$type}` 
        WHERE `id` = {$id} 
        LIMIT 1
    ");
    if (!$row = hesk_dbFetchAssoc($res)) {
        hesk_process_messages($hesklang['asset_not_found'], 'manage_components.php');
        exit;
    }
    // overwrite defaults
    foreach ($row as $k => $v) {
        if (array_key_exists($k, $default_values)) {
            $default_values[$k] = $v;
        }
    }
}

// Handle form submit
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    try_save_component();
}

// Print header & navigation
require_once(HESK_PATH . 'inc/header.inc.php');
require_once(HESK_PATH . 'inc/show_admin_nav.inc.php');
if (hesk_SESSION('iserror')) {
    hesk_handle_messages();
}
?>
</style>
<div class="main__content assets asset-create">
    <section class="assets__head">
        <h2>
            <?php echo $editing ? $hesklang['edit_computer'] : $hesklang['create_computer']; ?>
        </h2>
    </section>

    <div class="table-wrap">
        <form method="post" action="manage_component.php" class="form grid-form">
            <input type="hidden" name="token" value="<?php hesk_token_echo(); ?>">
            <input type="hidden" name="original_id" value="<?php echo $id; ?>">
        </form>
    </div>
</div>

<?php
function try_save_component() {
}
require_once(HESK_PATH . 'inc/footer.inc.php');