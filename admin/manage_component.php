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
    'psu'         => 'ps',
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
            <?php
            switch ($type) {
                case 'cpu':
                    ?>
                    <div class="form-group">
                        <label for="model"><?php echo $hesklang['model']; ?></label>
                        <input type="text" name="model" id="model" value="<?php echo htmlspecialchars($default_values['model']); ?>" required>
                    </div>
                    <div class="form-group">
                        <label for="cores"><?php echo $hesklang['cores']; ?></label>
                        <input type="number" name="cores" id="cores" value="<?php echo htmlspecialchars($default_values['cores']); ?>" min="1" required>
                    </div>
                    <div class="form-group">
                        <label for="threads"><?php echo $hesklang['threads']; ?></label>
                        <input type="number" name="threads" id="threads" value="<?php echo htmlspecialchars($default_values['threads']); ?>" min="1" required>
                    </div>
                    <?php
                    break;

                case 'disk':
                    ?>
                    <div class="form-group">
                        <label for="model"><?php echo $hesklang['model']; ?></label>
                        <input type="text" name="model" id="model" value="<?php echo htmlspecialchars($default_values['model']); ?>" required>
                    </div>
                    <div class="form-group">
                        <label for="disk_type"><?php echo $hesklang['disk_type']; ?></label>
                        <input type="text" name="disk_type" id="disk_type" value="<?php echo htmlspecialchars($default_values['disk_type']); ?>" required>
                    </div>
                    <div class="form-group">
                        <label for="interface"><?php echo $hesklang['interface']; ?></label>
                        <input type="text" name="interface" id="interface" value="<?php echo htmlspecialchars($default_values['interface']); ?>" required>
                    </div>
                    <div class="form-group">
                        <label for="speed_rpm"><?php echo $hesklang['speed_rpm']; ?></label>
                        <input type="number" name="speed_rpm" id="speed_rpm" value="<?php echo htmlspecialchars($default_values['speed_rpm']); ?>">
                    </div>
                    <div class="form-group">
                        <label for="capacity_gb"><?php echo $hesklang['capacity_gb']; ?></label>
                        <input type="number" name="capacity_gb" id="capacity_gb" value="<?php echo htmlspecialchars($default_values['capacity_gb']); ?>" min="1" required>
                    </div>
                    <?php
                    break;

                case 'mb':
                    ?>
                    <div class="form-group">
                        <label for="model"><?php echo $hesklang['model']; ?></label>
                        <input type="text" name="model" id="model" value="<?php echo htmlspecialchars($default_values['model']); ?>" required>
                    </div>
                    <div class="form-group">
                        <label for="ram_slots"><?php echo $hesklang['ram_slots']; ?></label>
                        <input type="number" name="ram_slots" id="ram_slots" value="<?php echo htmlspecialchars($default_values['ram_slots']); ?>" min="1" required>
                    </div>
                    <div class="form-group">
                        <label for="ram_max_storage_gb"><?php echo $hesklang['ram_max_storage_gb']; ?></label>
                        <input type="number" name="ram_max_storage_gb" id="ram_max_storage_gb" value="<?php echo htmlspecialchars($default_values['ram_max_storage_gb']); ?>" min="1" required>
                    </div>
                    <div class="form-group">
                        <label for="ram_type"><?php echo $hesklang['ram_type']; ?></label>
                        <input type="text" name="ram_type" id="ram_type" value="<?php echo htmlspecialchars($default_values['ram_type']); ?>" required>
                    </div>
                    <div class="form-group">
                        <label for="ram_max_speed_mhz"><?php echo $hesklang['ram_max_speed_mhz']; ?></label>
                        <input type="number" name="ram_max_speed_mhz" id="ram_max_speed_mhz" value="<?php echo htmlspecialchars($default_values['ram_max_speed_mhz']); ?>">
                    </div>
                    <div class="form-group">
                        <label for="chipset"><?php echo $hesklang['chipset']; ?></label>
                        <input type="text" name="chipset" id="chipset" value="<?php echo htmlspecialchars($default_values['chipset']); ?>">
                    </div>
                    <div class="form-group">
                        <label for="network_iface"><?php echo $hesklang['network_iface']; ?></label>
                        <input type="text" name="network_iface" id="network_iface" value="<?php echo htmlspecialchars($default_values['network_iface']); ?>">
                    </div>
                    <div class="form-group">
                        <label for="usb_ports"><?php echo $hesklang['usb_ports']; ?></label>
                        <input type="text" name="usb_ports" id="usb_ports" value="<?php echo htmlspecialchars($default_values['usb_ports']); ?>">
                    </div>
                    <div class="form-group">
                        <label for="video_ports"><?php echo $hesklang['video_ports']; ?></label>
                        <input type="text" name="video_ports" id="video_ports" value="<?php echo htmlspecialchars($default_values['video_ports']); ?>">
                    </div>
                    <div class="form-group">
                        <label for="storage_ifaces"><?php echo $hesklang['storage_ifaces']; ?></label>
                        <input type="text" name="storage_ifaces" id="storage_ifaces" value="<?php echo htmlspecialchars($default_values['storage_ifaces']); ?>">
                    </div>
                    <?php
                    break;

                case 'ps':
                    ?>
                    <div class="form-group">
                        <label for="model"><?php echo $hesklang['model']; ?></label>
                        <input type="text" name="model" id="model" value="<?php echo htmlspecialchars($default_values['model']); ?>" required>
                    </div>
                    <div class="form-group">
                        <label for="wattage_w"><?php echo $hesklang['wattage_w']; ?></label>
                        <input type="number" name="wattage_w" id="wattage_w" value="<?php echo htmlspecialchars($default_values['wattage_w']); ?>" min="1" required>
                    </div>
                    <div class="form-group">
                        <label for="is_bivolt"><?php echo $hesklang['is_bivolt']; ?></label>
                        <input type="checkbox" name="is_bivolt" id="is_bivolt" value="1" <?php if ($default_values['is_bivolt']) echo 'checked'; ?>>
                    </div>
                    <?php
                    break;

                case 'ram':
                    ?>
                    <div class="form-group">
                        <label for="model"><?php echo $hesklang['model']; ?></label>
                        <input type="text" name="model" id="model" value="<?php echo htmlspecialchars($default_values['model']); ?>" required>
                    </div>
                    <div class="form-group">
                        <label for="size_gb"><?php echo $hesklang['size_gb']; ?></label>
                        <input type="number" name="size_gb" id="size_gb" value="<?php echo htmlspecialchars($default_values['size_gb']); ?>" min="1" required>
                    </div>
                    <div class="form-group">
                        <label for="speed_mhz"><?php echo $hesklang['speed_mhz']; ?></label>
                        <input type="number" name="speed_mhz" id="speed_mhz" value="<?php echo htmlspecialchars($default_values['speed_mhz']); ?>">
                    </div>
                    <div class="form-group">
                        <label for="ram_type"><?php echo $hesklang['ram_type']; ?></label>
                        <input type="text" name="ram_type" id="ram_type" value="<?php echo htmlspecialchars($default_values['ram_type']); ?>" required>
                    </div>
                    <?php
                    break;
            }
            ?>
            <div class="form-group">
                <button type="submit" class="btn btn-full"><?php echo $editing ? $hesklang['save_changes'] : $hesklang['create']; ?></button>
            </div>
        </form>
    </div>
</div>

<?php
function try_save_component() {
}
require_once(HESK_PATH . 'inc/footer.inc.php');