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

// Are we editing, deleting or viewing?
$do  = hesk_GET('do', '');
$editing = ($do === 'edit');
$viewing = ($do === 'view'); 
$deleting = ($do === 'delete'); 

// Get type to know wich form to display
$type_param = $_SERVER['REQUEST_METHOD'] === 'POST' ? hesk_POST('type', '') : hesk_GET('type', '');
$types = array(
    'cpu'         => 'cpu',
    'ram'         => 'ram',
    'motherboard' => 'mb',
    'psu'         => 'ps',
    'disk'        => 'disk'
); 
if (!isset($types[$type_param])) {
    hesk_process_messages('Tipo de componente inválido.', 'manage_components.php', 'ERROR');
    exit;
}
$type = $types[$type_param];

// Prepare default values
$default_values = [];
switch ($type) {
    case 'cpu':
        $default_values = [
            'id'        => '',
            'model'     => '',
            'cores'     => '',
            'threads'   => '',
            'created_at'=> '',
            'updated_at'=> '',
        ];
        break;
    case 'disk':
        $default_values = [
            'id'          => '',
            'model'       => '',
            'disk_type'   => '',
            'interface'   => '',
            'speed_rpm'   => '',
            'capacity_gb' => '',
            'created_at'  => '',
            'updated_at'  => '',
        ];
        break;
    case 'mb':
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
            'created_at'         => '',
            'updated_at'         => '',
        ];
        break;
    case 'ps':
        $default_values = [
            'id'         => '',
            'model'      => '',
            'wattage_w'  => '',
            'is_bivolt'  => 0,
            'created_at' => '',
            'updated_at' => '',
        ];
        break;
    case 'ram':
        $default_values = [
            'id'         => '',
            'model'      => '',
            'size_gb'    => '',
            'speed_mhz'  => '',
            'ram_type'   => '',
            'created_at' => '',
            'updated_at' => '',
        ];
        break;
}

// If editing or loading, load existing component
$id = hesk_GET('id', 0);
if ($editing || $viewing) {
    $res = hesk_dbQuery("
        SELECT * 
        FROM `{$dbp}{$type}` 
        WHERE `id` = {$id} 
        LIMIT 1
    ");
    if (!$row = hesk_dbFetchAssoc($res)) {
        hesk_process_messages($hesklang['asset_not_found'], 'manage_components.php', 'ERROR');
        exit;
    }
    // overwrite defaults
    foreach ($row as $k => $v) {
        if (array_key_exists($k, $default_values)) {
            $default_values[$k] = $v;
        }
    }
} elseif ($deleting && ($id > 0)) {
    $res = hesk_dbQuery("
        UPDATE `{$dbp}{$type}` 
        SET `is_active` = 0 
        WHERE `id` = {$id} 
        LIMIT 1
    ");
    hesk_process_messages($hesklang['asset_deleted'], 'manage_components.php', 'SUCCESS');
    exit;
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
<style>
.form-group > .flex-options {
    display: flex;
    gap: 1rem;
}
</style>
<div class="main__content assets asset-create">
    <section class="assets__head">
        <h2>
            <?php echo $editing ? $hesklang['edit_component'] : ($viewing ? $hesklang['view_component'] : $hesklang['create_component']); ?>
        </h2>
    </section>

    <div class="table-wrap">
        <form method="post" action="manage_component.php" class="form grid-form">
            <input type="hidden" name="token" value="<?php hesk_token_echo(); ?>">
            <input type="hidden" name="original_id" value="<?php echo $id; ?>">
            <input type="hidden" name="type" value="<?php echo htmlspecialchars($type_param); ?>">
            <?php
            switch ($type) {
                case 'cpu':
                    ?>
                    <div class="grid-3">
                        <div class="form-group">
                            <label for="model"><?php echo $hesklang['model']; ?></label>
                            <input type="text" name="model" id="model" class="form-control" value="<?php echo hesk_htmlspecialchars($default_values['model']); ?>" required <?php if ($viewing) echo 'disabled'; ?>>
                        </div>
                        <div class="form-group">
                            <label for="cores"><?php echo $hesklang['cores']; ?></label>
                            <input type="number" name="cores" id="cores" class="form-control" value="<?php echo hesk_htmlspecialchars($default_values['cores']); ?>" min="1" <?php if ($viewing) echo 'disabled'; ?>>
                        </div>
                        <div class="form-group">
                            <label for="threads"><?php echo $hesklang['threads']; ?></label>
                            <input type="number" name="threads" id="threads" class="form-control" value="<?php echo hesk_htmlspecialchars($default_values['threads']); ?>" min="1" <?php if ($viewing) echo 'disabled'; ?>>
                        </div>
                    </div>
                    <?php if ($viewing): ?>
                        <div class="grid-2">
                            <div class="form-group">
                                <label for="created_at"><?php echo $hesklang['created_at']; ?>:</label>
                                <input type="text" name="created_at" id="created_at" class="form-control" value="<?php echo date('H:i:s - d/m/Y', strtotime($default_values['created_at'])); ?>" disabled>
                            </div>
                            <div class="form-group">
                                <label for="updated_at"><?php echo $hesklang['updated_at']; ?>:</label>
                                <input type="text" name="updated_at" id="updated_at" class="form-control" value="<?php echo date('H:i:s - d/m/Y', strtotime($default_values['updated_at'])); ?>" disabled>
                            </div>
                        </div>
                    <?php endif;
                    break;

                case 'disk':
                    ?>
                    <div class="grid-3">
                        <div class="form-group">
                            <label for="model"><?php echo $hesklang['model']; ?></label>
                            <input type="text" name="model" id="model" class="form-control" value="<?php echo hesk_htmlspecialchars($default_values['model']); ?>" required <?php if ($viewing) echo 'disabled'; ?>>
                        </div>
                        <div class="form-group">
                            <label for="speed_rpm"><?php echo $hesklang['speed_rpm']; ?></label>
                            <input type="number" name="speed_rpm" id="speed_rpm" class="form-control" value="<?php echo hesk_htmlspecialchars($default_values['speed_rpm']); ?>" <?php if ($viewing) echo 'disabled'; ?>>
                        </div>
                        <div class="form-group">
                            <label for="capacity_gb"><?php echo $hesklang['capacity_gb']; ?></label>
                            <input type="number" name="capacity_gb" id="capacity_gb" class="form-control" value="<?php echo hesk_htmlspecialchars($default_values['capacity_gb']); ?>" min="1" required <?php if ($viewing) echo 'disabled'; ?>>
                        </div>
                    </div>
                    <div class="grid-2">
                        <div class="form-group">
                            <label for="interface"><?php echo $hesklang['interface']; ?></label>
                            <div class="flex-options">
                                <label>
                                    <input type="radio" name="interface" value="SATA" <?php if ($default_values['interface'] === 'SATA') echo 'checked'; ?> required <?php if ($viewing) echo 'disabled'; ?>>
                                    SATA
                                </label>
                                <label>
                                    <input type="radio" name="interface" value="SAS" <?php if ($default_values['interface'] === 'SAS') echo 'checked'; ?> <?php if ($viewing) echo 'disabled'; ?>>
                                    SAS
                                </label>
                                <label>
                                    <input type="radio" name="interface" value="NVMe" <?php if ($default_values['interface'] === 'NVMe') echo 'checked'; ?> <?php if ($viewing) echo 'disabled'; ?>>
                                    NVMe
                                </label>
                                <label>
                                    <input type="radio" name="interface" value="IDE" <?php if ($default_values['interface'] === 'IDE') echo 'checked'; ?> <?php if ($viewing) echo 'disabled'; ?>>
                                    IDE
                                </label>
                                <label>
                                    <input type="radio" name="interface" value="SCSI" <?php if ($default_values['interface'] === 'SCSI') echo 'checked'; ?> <?php if ($viewing) echo 'disabled'; ?>>
                                    SCSI
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="disk_type"><?php echo $hesklang['type']; ?></label>
                            <div class="flex-options">
                                <label>
                                    <input type="radio" name="disk_type" value="HDD" <?php if ($default_values['disk_type'] === 'HDD') echo 'checked'; ?> required <?php if ($viewing) echo 'disabled'; ?>>
                                    HDD
                                </label>
                                <label>
                                    <input type="radio" name="disk_type" value="SSD" <?php if ($default_values['disk_type'] === 'SSD') echo 'checked'; ?> <?php if ($viewing) echo 'disabled'; ?>>
                                    SSD
                                </label>
                                <label>
                                    <input type="radio" name="disk_type" value="NVMe" <?php if ($default_values['disk_type'] === 'NVMe') echo 'checked'; ?> <?php if ($viewing) echo 'disabled'; ?>>
                                    NVMe
                                </label>
                            </div>
                        </div>
                    </div>
                    <?php if ($viewing): ?>
                        <div class="grid-2">
                            <div class="form-group">
                                <label for="created_at"><?php echo $hesklang['created_at']; ?>:</label>
                                <input type="text" name="created_at" id="created_at" class="form-control" value="<?php echo date('H:i:s - d/m/Y', strtotime($default_values['created_at'])); ?>" disabled>
                            </div>
                            <div class="form-group">
                                <label for="updated_at"><?php echo $hesklang['updated_at']; ?>:</label>
                                <input type="text" name="updated_at" id="updated_at" class="form-control" value="<?php echo date('H:i:s - d/m/Y', strtotime($default_values['updated_at'])); ?>" disabled>
                            </div>
                        </div>
                    <?php endif;
                    break;

                case 'mb':
                    ?>
                    <div class="grid-3">
                        <div class="form-group">
                            <label for="model"><?php echo $hesklang['model']; ?></label>
                            <input type="text" name="model" id="model" class="form-control" value="<?php echo hesk_htmlspecialchars($default_values['model']); ?>" required <?php if ($viewing) echo 'disabled'; ?>>
                        </div>
                        <div class="form-group">
                            <label for="ram_slots"><?php echo $hesklang['ram_slots']; ?></label>
                            <input type="number" name="ram_slots" id="ram_slots" class="form-control" value="<?php echo hesk_htmlspecialchars($default_values['ram_slots']); ?>" min="1" <?php if ($viewing) echo 'disabled'; ?>>
                        </div>
                        <div class="form-group">
                            <label for="ram_max_storage_gb"><?php echo $hesklang['ram_max_storage_gb']; ?></label>
                            <input type="number" name="ram_max_storage_gb" id="ram_max_storage_gb" class="form-control" value="<?php echo hesk_htmlspecialchars($default_values['ram_max_storage_gb']); ?>" min="1" <?php if ($viewing) echo 'disabled'; ?>>
                        </div>
                    </div>
                    <div class="grid-2">
                        <div class="form-group">
                            <label for="video_ports"><?php echo $hesklang['video_ports']; ?></label>
                            <div class="flex-options">
                                <label>
                                    <input type="checkbox" name="video_ports[]" value="HDMI" <?php if (strpos($default_values['video_ports'], 'HDMI') !== false) echo 'checked'; ?> <?php if ($viewing) echo 'disabled'; ?>>
                                    HDMI
                                </label>
                                <label>
                                    <input type="checkbox" name="video_ports[]" value="DisplayPort" <?php if (strpos($default_values['video_ports'], 'DisplayPort') !== false) echo 'checked'; ?> <?php if ($viewing) echo 'disabled'; ?>>
                                    DisplayPort
                                </label>
                                <label>
                                    <input type="checkbox" name="video_ports[]" value="VGA" <?php if (strpos($default_values['video_ports'], 'VGA') !== false) echo 'checked'; ?> <?php if ($viewing) echo 'disabled'; ?>>
                                    VGA
                                </label>
                                <label>
                                    <input type="checkbox" name="video_ports[]" value="DVI" <?php if (strpos($default_values['video_ports'], 'DVI') !== false) echo 'checked'; ?> <?php if ($viewing) echo 'disabled'; ?>>
                                    DVI
                                </label>
                                <label>
                                    <input type="checkbox" name="video_ports[]" value="USB-C" <?php if (strpos($default_values['video_ports'], 'USB-C') !== false) echo 'checked'; ?> <?php if ($viewing) echo 'disabled'; ?>>
                                    USB-C
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="ram_max_speed_mhz"><?php echo $hesklang['ram_max_speed_mhz']; ?></label>
                            <input type="number" name="ram_max_speed_mhz" id="ram_max_speed_mhz" class="form-control" value="<?php echo hesk_htmlspecialchars($default_values['ram_max_speed_mhz']); ?>" <?php if ($viewing) echo 'disabled'; ?>>
                        </div>
                    </div>
                    <div class="grid-2">
                        <div class="form-group">
                            <label for="network_iface"><?php echo $hesklang['network_iface']; ?></label>
                            <div class="flex-options">
                                <label>
                                    <input type="radio" name="network_iface" value="Ethernet" <?php if ($default_values['network_iface'] === 'Ethernet') echo 'checked'; ?> required <?php if ($viewing) echo 'disabled'; ?>>
                                    <?php echo $hesklang['ethernet']; ?>
                                </label>
                                <label>
                                    <input type="radio" name="network_iface" value="WiFi" <?php if ($default_values['network_iface'] === 'WiFi') echo 'checked'; ?> <?php if ($viewing) echo 'disabled'; ?>>
                                    <?php echo $hesklang['wifi']; ?>
                                </label>
                                <label>
                                    <input type="radio" name="network_iface" value="Ethernet+WiFi" <?php if ($default_values['network_iface'] === 'Ethernet+WiFi') echo 'checked'; ?> <?php if ($viewing) echo 'disabled'; ?>>
                                    <?php echo $hesklang['both']; ?>
                                </label>
                            </div>                    
                        </div>
                        <div class="form-group">
                            <label for="chipset"><?php echo $hesklang['chipset']; ?></label>
                            <input type="text" name="chipset" id="chipset" class="form-control" value="<?php echo hesk_htmlspecialchars($default_values['chipset']); ?>" <?php if ($viewing) echo 'disabled'; ?>>
                        </div>
                    </div>
                    <div class="grid-3">
                        <div class="form-group">
                            <label for="ram_type"><?php echo $hesklang['rams']; ?> <?php echo $hesklang['type']; ?></label>
                            <div class="flex-options">
                                <label>
                                    <input type="radio" name="ram_type" value="DDR3" <?php if ($default_values['ram_type'] === 'DDR3') echo 'checked'; ?> required <?php if ($viewing) echo 'disabled'; ?>>
                                    DDR3
                                </label>
                                <label>
                                    <input type="radio" name="ram_type" value="DDR4" <?php if ($default_values['ram_type'] === 'DDR4') echo 'checked'; ?> <?php if ($viewing) echo 'disabled'; ?>>
                                    DDR4
                                </label>
                                <label>
                                    <input type="radio" name="ram_type" value="DDR5" <?php if ($default_values['ram_type'] === 'DDR5') echo 'checked'; ?> <?php if ($viewing) echo 'disabled'; ?>>
                                    DDR5
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="storage_ifaces"><?php echo $hesklang['storage_ifaces']; ?></label>
                            <div class="flex-options">
                                <label>
                                    <input type="checkbox" name="storage_ifaces[]" value="SATA" <?php if (strpos($default_values['storage_ifaces'], 'SATA') !== false) echo 'checked'; ?> required <?php if ($viewing) echo 'disabled'; ?>>
                                    SATA
                                </label>
                                <label>
                                    <input type="checkbox" name="storage_ifaces[]" value="SAS" <?php if (strpos($default_values['storage_ifaces'], 'SAS') !== false) echo 'checked'; ?> <?php if ($viewing) echo 'disabled'; ?>>
                                    SAS
                                </label>
                                <label>
                                    <input type="checkbox" name="storage_ifaces[]" value="NVMe" <?php if (strpos($default_values['storage_ifaces'], 'NVMe') !== false) echo 'checked'; ?> <?php if ($viewing) echo 'disabled'; ?>>
                                    NVMe
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="usb_ports"><?php echo $hesklang['usb_ports']; ?></label>
                            <input type="number" name="usb_ports" id="usb_ports" class="form-control" value="<?php echo hesk_htmlspecialchars($default_values['usb_ports']); ?>" <?php if ($viewing) echo 'disabled'; ?>>
                        </div>
                    </div>
                    <?php if ($viewing): ?>
                        <div class="grid-2">
                            <div class="form-group">
                                <label for="created_at"><?php echo $hesklang['created_at']; ?>:</label>
                                <input type="text" name="created_at" id="created_at" class="form-control" value="<?php echo date('H:i:s - d/m/Y', strtotime($default_values['created_at'])); ?>" disabled>
                            </div>
                            <div class="form-group">
                                <label for="updated_at"><?php echo $hesklang['updated_at']; ?>:</label>
                                <input type="text" name="updated_at" id="updated_at" class="form-control" value="<?php echo date('H:i:s - d/m/Y', strtotime($default_values['updated_at'])); ?>" disabled>
                            </div>
                        </div>
                    <?php endif;
                    break;

                case 'ps':
                    ?>
                    <div class="grid-3">
                        <div class="form-group">
                            <label for="model"><?php echo $hesklang['model']; ?></label>
                            <input type="text" name="model" id="model" class="form-control" value="<?php echo hesk_htmlspecialchars($default_values['model']); ?>" required <?php if ($viewing) echo 'disabled'; ?>>
                        </div>
                        <div class="form-group">
                            <label for="wattage_w"><?php echo $hesklang['wattage_w']; ?></label>
                            <input type="number" name="wattage_w" id="wattage_w" class="form-control" value="<?php echo hesk_htmlspecialchars($default_values['wattage_w']); ?>" min="1" required <?php if ($viewing) echo 'disabled'; ?>>
                        </div>
                        <div class="form-group">
                            <label for="is_bivolt"><?php echo $hesklang['is_bivolt']; ?></label>
                            <input type="checkbox" name="is_bivolt" value="is_bivolt" <?php if ($default_values['is_bivolt']) echo 'checked'; ?> <?php if ($viewing) echo 'disabled'; ?>>
                        </div>
                    </div>
                    <?php if ($viewing): ?>
                        <div class="grid-2">
                            <div class="form-group">
                                <label for="created_at"><?php echo $hesklang['created_at']; ?>:</label>
                                <input type="text" name="created_at" id="created_at" class="form-control" value="<?php echo date('H:i:s - d/m/Y', strtotime($default_values['created_at'])); ?>" disabled>
                            </div>
                            <div class="form-group">
                                <label for="updated_at"><?php echo $hesklang['updated_at']; ?>:</label>
                                <input type="text" name="updated_at" id="updated_at" class="form-control" value="<?php echo date('H:i:s - d/m/Y', strtotime($default_values['updated_at'])); ?>" disabled>
                            </div>
                        </div>
                    <?php endif;
                    break;

                case 'ram':
                    ?>
                    <div class="grid-2">
                        <div class="form-group">
                            <label for="model"><?php echo $hesklang['model']; ?></label>
                            <input type="text" name="model" id="model" class="form-control" value="<?php echo hesk_htmlspecialchars($default_values['model']); ?>" required <?php if ($viewing) echo 'disabled'; ?>>
                        </div>
                        <div class="form-group">
                            <label for="size_gb"><?php echo $hesklang['size_gb']; ?></label>
                            <input type="number" name="size_gb" id="size_gb" class="form-control" value="<?php echo hesk_htmlspecialchars($default_values['size_gb']); ?>" min="1" required <?php if ($viewing) echo 'disabled'; ?>>
                        </div>
                    </div>
                    <div class="grid-2">
                        <div class="form-group">
                            <label for="speed_mhz"><?php echo $hesklang['speed_mhz']; ?></label>
                            <input type="number" name="speed_mhz" id="speed_mhz" class="form-control" value="<?php echo hesk_htmlspecialchars($default_values['speed_mhz']); ?>" <?php if ($viewing) echo 'disabled'; ?>>
                        </div>
                        <div class="form-group">
                            <label for="ram_type"><?php echo $hesklang['type']; ?></label>
                            <div class="flex-options">
                                <label>
                                    <input type="radio" name="ram_type" value="DDR3" <?php if ($default_values['ram_type'] === 'DDR3') echo 'checked'; ?> required <?php if ($viewing) echo 'disabled'; ?>>
                                    DDR3
                                </label>
                                <label>
                                    <input type="radio" name="ram_type" value="DDR4" <?php if ($default_values['ram_type'] === 'DDR4') echo 'checked'; ?> <?php if ($viewing) echo 'disabled'; ?>>
                                    DDR4
                                </label>
                                <label>
                                    <input type="radio" name="ram_type" value="DDR5" <?php if ($default_values['ram_type'] === 'DDR5') echo 'checked'; ?> <?php if ($viewing) echo 'disabled'; ?>>
                                    DDR5
                                </label>
                            </div>                        </div>
                        </div>
                    <?php if ($viewing): ?>
                        <div class="grid-2">
                            <div class="form-group">
                                <label for="created_at"><?php echo $hesklang['created_at']; ?>:</label>
                                <input type="text" name="created_at" id="created_at" class="form-control" value="<?php echo date('H:i:s - d/m/Y', strtotime($default_values['created_at'])); ?>" disabled>
                            </div>
                            <div class="form-group">
                                <label for="updated_at"><?php echo $hesklang['updated_at']; ?>:</label>
                                <input type="text" name="updated_at" id="updated_at" class="form-control" value="<?php echo date('H:i:s - d/m/Y', strtotime($default_values['updated_at'])); ?>" disabled>
                            </div>
                        </div>
                    <?php endif;
                    break;
            }
            if (!$viewing):
            ?>
            <div class="grid-2 form-group">
                <button type="submit" class="btn btn-full btn--primary"><?php echo $editing ? $hesklang['save'] : $hesklang['create']; ?></button>
                <a class="btn btn--blue-border" href="manage_components.php"><?php echo $hesklang['cancel'] ?></a>
            </div>
            <?php endif; ?>
        </form>
    </div>
</div>

<?php
function try_save_component() {
    global $dbp, $type, $hesklang, $editing;
    hesk_token_check('POST');

    $orig_id = intval(hesk_POST('original_id', 0));
    $data      = [];
    $required  = []; 
    
    // Determine if editing based on POSTed id if $editing is not set
    if (!isset($editing) || !$editing) {
        $editing = ($orig_id > 0);
    }

    switch ($type) {
        case 'cpu':
            $data = [
                'model'   => hesk_input(hesk_POST('model')),
                'cores'   => intval(hesk_POST('cores', 0)),
                'threads' => intval(hesk_POST('threads', 0)),
            ];
            $required = ['model'];
            break;

        case 'disk':
            $data = [
                'model'       => hesk_input(hesk_POST('model')),
                'disk_type'   => hesk_POST('disk_type'),
                'interface'   => hesk_POST('interface'),
                'speed_rpm'   => hesk_POST('speed_rpm') === '' ? null : intval(hesk_POST('speed_rpm')),
                'capacity_gb' => intval(hesk_POST('capacity_gb', 0)),
            ];
            $required = ['model', 'capacity_gb'];
            break;

        case 'mb':
            // helper to support multi-select checkbox/radio groups
            $csv = function ($key)
            {
                if (!isset($_POST[$key])) {
                    return '';
                }
                return is_array($_POST[$key]) ? implode(',', array_map('hesk_input', $_POST[$key])) : hesk_input($_POST[$key]);
            };

            $data = [
                'model'               => hesk_input(hesk_POST('model')),
                'ram_slots'           => intval(hesk_POST('ram_slots', 0)),
                'ram_type'            => hesk_POST('ram_type'),
                'ram_max_storage_gb'  => intval(hesk_POST('ram_max_storage_gb', 0)),
                'ram_max_speed_mhz'   => hesk_POST('ram_max_speed_mhz') === '' ? null : intval(hesk_POST('ram_max_speed_mhz')),
                'chipset'             => hesk_input(hesk_POST('chipset')),
                'network_iface'       => hesk_POST('network_iface'),
                'usb_ports'           => hesk_POST('usb_ports') === '' ? null : intval(hesk_POST('usb_ports')),
                'video_ports'         => $csv('video_ports'),
                'storage_ifaces'      => $csv('storage_ifaces'),
            ];
            $required = ['model', 'ram_slots', 'ram_type', 'ram_max_storage_gb'];
            break;

        case 'ps':
            $data = [
                'model'     => hesk_input(hesk_POST('model')),
                'wattage_w' => intval(hesk_POST('wattage_w', 0)),
                'is_bivolt' => isset($_POST['is_bivolt']) ? 1 : 0,
            ];
            $required = ['model', 'wattage_w'];
            break;

        case 'ram':
            $data = [
                'model'     => hesk_input(hesk_POST('model')),
                'size_gb'   => intval(hesk_POST('size_gb', 0)),
                'speed_mhz' => hesk_POST('speed_mhz') === '' ? null : intval(hesk_POST('speed_mhz')),
                'ram_type'  => hesk_POST('ram_type'),
            ];
            $required = ['model', 'size_gb', 'ram_type'];
            break;
    }

    // Required fields for creation
    if (!$editing) {
        foreach ($required as $k) {
            if ($data[$k] === '' || $data[$k] === null) {
                $_SESSION['iserror'] = 1;
                hesk_process_messages($hesklang['fill_required'], 'NOREDIRECT');
                break;
            }
        }
    }

    // rollback on error
    if (isset($_SESSION['iserror'])) {
        header('Location: manage_component.php?type=' . $type . ($orig_id ? '&id=' . $orig_id : ''));
        exit;
    }
    
    // Build SET clause
    $cols = [];
    foreach ($data as $col => $val) {
        if ($val === '' || $val === null) {
            $cols[] = "`$col` = NULL";
        } elseif (is_numeric($val)) {
            $cols[] = "`$col` = $val";
        } else {
            $cols[] = "`$col` = '" . hesk_dbEscape($val) . "'";
        }
    }
    $cols = implode(",\n        ", $cols);
    error_log("COLS: " . print_r($cols, true));
    error_log("DATA: " . print_r($data, true));

    // Execute queries
    if ($editing) {
        $result = hesk_dbQuery("UPDATE `{$dbp}{$type}` SET $cols WHERE `id` = $orig_id");
        if (!$result) {
            die('SQL Error: ' . mysqli_error($GLOBALS['hesk_db_link']));
        }
        $msg = sprintf($hesklang['component_updated'], '<i>' . hesk_htmlspecialchars($data['model']) . '</i>');
    } else {
        error_log("QUERY: INSERT INTO `{$dbp}{$type}` SET $cols");
        $result = hesk_dbQuery("INSERT INTO `{$dbp}{$type}` SET $cols");
        if (!$result) {
            error_log('SQL Error: ' . mysqli_error($GLOBALS['hesk_db_link']));
            die('SQL Error: ' . mysqli_error($GLOBALS['hesk_db_link']));
        }
        $msg = sprintf($hesklang['component_added'], '<i>' . hesk_htmlspecialchars($data['model']) . '</i>');
    }
    
    hesk_cleanSessionVars('iserror');
    hesk_process_messages($msg, 'manage_components.php', 'SUCCESS');
    exit;
}
require_once(HESK_PATH . 'inc/footer.inc.php');