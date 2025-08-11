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
$type_param = strtolower($type_param);
$types = array(
    'cpu'         => 'cpu',
    'ram'         => 'ram',
    'motherboard' => 'mb',
    'psu'         => 'ps',
    'disk'        => 'disk'
); 
if (!isset($types[$type_param])) {
    hesk_process_messages($hesklang['invalid_component'], 'manage_components.php', 'ERROR');
    exit;
}
$type = $types[$type_param];

// Prepare default values
$default_values = [];
switch ($type) {
    case 'cpu':
        $default_values = [
            'id'         => '',
            'model'      => '',
            'cores'      => '',
            'threads'    => '',
            'ghz'        => '',
            'gpu'        => '',
            'link'       => '',
            'stock'      => 1,
            'created_at' => '',
            'updated_at' => '',
        ];
        break;
    case 'disk':
        $default_values = [
            'id'          => '',
            'model'       => '',
            'type'        => '',
            'interface'   => '',
            'size_gb'     => '',
            'link'        => '',
            'stock'       => 1,
            'created_at'  => '',
            'updated_at'  => '',
        ];
        break;
    case 'mb':
        $default_values = [
            'id'             => '',
            'model'          => '',
            'ddr'            => '',
            'ram_slots'      => '',
            'max_ram_gb'     => '',
            'chipset'        => '',
            'network_iface'  => '',
            'storage_ifaces' => '',
            'link'           => '',
            'stock'          => 1,
            'created_at'     => '',
            'updated_at'     => '',
        ];
        break;
    case 'ps':
        $default_values = [
            'id'         => '',
            'model'      => '',
            'wattage_w'  => '',
            'is_bivolt'  => 0,
            'stock'      => 1,
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
            'link'       => '',
            'stock'      => 1,
            'created_at' => '',
            'updated_at' => '',
        ];
        break;
}

// If editing or loading, load existing component
$id = hesk_GET('id', 0);
if ($editing || $viewing) {
    $res = hesk_dbQuery("
        SELECT * FROM `{$dbp}{$type}` 
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
    hesk_process_messages(sprintf($hesklang['asset_deleted']),'manage_components.php','SUCCESS');
    exit();
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
            if ($editing): ?>
            <input type="hidden" name="edit" value="1">
            <?php endif;
            switch ($type) {
                case 'cpu':
                    ?>
                    <div class="grid-3">
                        <div class="form-group">
                            <label for="model"><?php echo $hesklang['model']; ?>:<span class="important">*</span></label>
                            <input type="text" name="model" id="model" class="form-control" value="<?php echo hesk_htmlspecialchars($default_values['model']); ?>" required <?php if ($viewing) echo 'disabled'; ?>>
                        </div>
                        <div class="form-group">
                            <label for="cores"><?php echo $hesklang['cores']; ?>:<span class="important">*</span></label>
                            <input type="number" name="cores" id="cores" class="form-control" value="<?php echo hesk_htmlspecialchars($default_values['cores']); ?>" min="1" <?php if ($viewing) echo 'disabled'; ?>>
                        </div>
                        <div class="form-group">
                            <label for="threads"><?php echo $hesklang['threads']; ?>:<span class="important">*</span></label>
                            <input type="number" name="threads" id="threads" class="form-control" value="<?php echo hesk_htmlspecialchars($default_values['threads']); ?>" min="1" <?php if ($viewing) echo 'disabled'; ?>>
                        </div>
                    </div>
                    <div class="grid-4">
                        <div class="form-group">
                            <label for="ghz"><?php echo $hesklang['ghz']; ?>:</label>
                            <input type="number" name="ghz" id="ghz" class="form-control" step="0.1" value="<?php echo hesk_htmlspecialchars($default_values['ghz']); ?>" <?php if ($viewing) echo 'disabled'; ?>>
                        </div>
                        <div class="form-group">
                            <label for="gpu"><?php echo $hesklang['gpu']; ?>:</label>
                            <input type="text" name="gpu" id="gpu" class="form-control" value="<?php echo hesk_htmlspecialchars($default_values['gpu']); ?>" <?php if ($viewing) echo 'disabled'; ?>>
                        </div>
                        <div class="form-group">
                            <label for="link"><?php echo $hesklang['link']; ?>:</label>
                            <input type="url" name="link" id="link" class="form-control" value="<?php echo hesk_htmlspecialchars($default_values['link']); ?>" <?php if ($viewing) echo 'disabled'; ?>>
                        </div>
                        <div class="form-group">
                            <label for="stock"><?php echo $hesklang['stock']; ?>:</label>
                            <input type="number" name="stock" id="stock" class="form-control" value="<?php echo hesk_htmlspecialchars($default_values['stock']); ?>" <?php if ($viewing) echo 'disabled'; ?>>
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
                    <div class="grid-4">
                        <div class="form-group">
                            <label for="model"><?php echo $hesklang['model']; ?>:<span class="important">*</span></label>
                            <input type="text" name="model" id="model" class="form-control" value="<?php echo hesk_htmlspecialchars($default_values['model']); ?>" required <?php if ($viewing) echo 'disabled'; ?>>
                        </div>
                        <div class="form-group">
                            <label for="size_gb"><?php echo $hesklang['size_gb']; ?>:<span class="important">*</span></label>
                            <input type="number" name="size_gb" id="size_gb" class="form-control" value="<?php echo hesk_htmlspecialchars($default_values['size_gb']); ?>" min="1" required <?php if ($viewing) echo 'disabled'; ?>>
                        </div>
                        <div class="form-group">
                            <label for="stock"><?php echo $hesklang['stock']; ?>:</label>
                            <input type="number" name="stock" id="stock" class="form-control" value="<?php echo hesk_htmlspecialchars($default_values['stock']); ?>" <?php if ($viewing) echo 'disabled'; ?>>
                        </div>
                        <div class="form-group">
                            <label for="interface"><?php echo $hesklang['interface']; ?>:<span class="important">*</span></label>
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
                    </div>
                    <div class="grid-2">
                        <div class="form-group">
                            <label for="link"><?php echo $hesklang['link']; ?>:</label>
                            <input type="url" name="link" id="link" class="form-control" value="<?php echo hesk_htmlspecialchars($default_values['link']); ?>" <?php if ($viewing) echo 'disabled'; ?>>
                        </div>
                        <div class="form-group">
                            <label for="disk_type"><?php echo $hesklang['type']; ?>:<span class="important">*</span></label>
                            <div class="flex-options">
                                <label>
                                    <input type="radio" name="disk_type" value="HDD" <?php if ($default_values['type'] === 'HDD') echo 'checked'; ?> required <?php if ($viewing) echo 'disabled'; ?>>
                                    HDD
                                </label>
                                <label>
                                    <input type="radio" name="disk_type" value="SSD" <?php if ($default_values['type'] === 'SSD') echo 'checked'; ?> <?php if ($viewing) echo 'disabled'; ?>>
                                    SSD
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
                    <div class="grid-4">
                        <div class="form-group">
                            <label for="model"><?php echo $hesklang['model']; ?>:<span class="important">*</span></label>
                            <input type="text" name="model" id="model" class="form-control" value="<?php echo hesk_htmlspecialchars($default_values['model']); ?>" required <?php if ($viewing) echo 'disabled'; ?>>
                        </div>
                        <div class="form-group">
                            <label for="ram_slots"><?php echo $hesklang['ram_slots']; ?>:</label>
                            <input type="number" name="ram_slots" id="ram_slots" class="form-control" value="<?php echo hesk_htmlspecialchars($default_values['ram_slots']); ?>" min="1" <?php if ($viewing) echo 'disabled'; ?>>
                        </div>
                        <div class="form-group">
                            <label for="max_ram_gb"><?php echo $hesklang['max_ram_gb']; ?>:</label>
                            <input type="number" name="max_ram_gb" id="max_ram_gb" class="form-control" value="<?php echo hesk_htmlspecialchars($default_values['max_ram_gb']); ?>" min="1" <?php if ($viewing) echo 'disabled'; ?>>
                        </div>
                        <div class="form-group">
                            <label for="stock"><?php echo $hesklang['stock']; ?>:</label>
                            <input type="number" name="stock" id="stock" class="form-control" value="<?php echo hesk_htmlspecialchars($default_values['stock']); ?>" <?php if ($viewing) echo 'disabled'; ?>>
                        </div>
                    </div>
                    <div class="grid-3">
                        <div class="form-group">
                            <label for="network_iface"><?php echo $hesklang['network_iface']; ?>:</label>
                            <div class="flex-options">
                                <label>
                                    <input type="radio" name="network_iface" value="cable" <?php if ($default_values['network_iface'] === 'Ethernet') echo 'checked'; ?> <?php if ($viewing) echo 'disabled'; ?>>
                                    <?php echo $hesklang['cable']; ?>
                                </label>
                                <label>
                                    <input type="radio" name="network_iface" value="wifi" <?php if ($default_values['network_iface'] === 'WiFi') echo 'checked'; ?> <?php if ($viewing) echo 'disabled'; ?>>
                                    <?php echo $hesklang['wifi']; ?>
                                </label>
                                <label>
                                    <input type="radio" name="network_iface" value="both" <?php if ($default_values['network_iface'] === 'Ethernet+WiFi') echo 'checked'; ?> <?php if ($viewing) echo 'disabled'; ?>>
                                    <?php echo $hesklang['both']; ?>
                                </label>
                            </div>                    
                        </div>
                        <div class="form-group">
                            <label for="ddr"><?php echo $hesklang['rams']; ?> <?php echo $hesklang['type']; ?>:<span class="important">*</span></label>
                            <div class="flex-options">
                                <label>
                                    <input type="radio" name="ddr" value="DDR3" <?php if ($default_values['ddr'] === 'DDR3') echo 'checked'; ?> required <?php if ($viewing) echo 'disabled'; ?>>
                                    DDR3
                                </label>
                                <label>
                                    <input type="radio" name="ddr" value="DDR4" <?php if ($default_values['ddr'] === 'DDR4') echo 'checked'; ?> <?php if ($viewing) echo 'disabled'; ?>>
                                    DDR4
                                </label>
                                <label>
                                    <input type="radio" name="ddr" value="DDR5" <?php if ($default_values['ddr'] === 'DDR5') echo 'checked'; ?> <?php if ($viewing) echo 'disabled'; ?>>
                                    DDR5
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="storage_ifaces"><?php echo $hesklang['storage_ifaces']; ?>:<span class="important">*</span></label>
                            <div class="flex-options">
                                <label>
                                    <input type="checkbox" name="storage_ifaces[]" value="SATA" <?php if (strpos($default_values['storage_ifaces'], 'SATA') !== false) echo 'checked'; ?> <?php if ($viewing) echo 'disabled'; ?>>
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
                                <label>
                                    <input type="checkbox" name="storage_ifaces[]" value="RAID" <?php if (strpos($default_values['storage_ifaces'], 'RAID') !== false) echo 'checked'; ?> <?php if ($viewing) echo 'disabled'; ?>>
                                    RAID
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="grid-2">
                        <div class="form-group">
                            <label for="chipset"><?php echo $hesklang['chipset']; ?>:</label>
                            <input type="text" name="chipset" id="chipset" class="form-control" value="<?php echo hesk_htmlspecialchars($default_values['chipset']); ?>" <?php if ($viewing) echo 'disabled'; ?>>
                        </div>
                        <div class="form-group">
                            <label for="link"><?php echo $hesklang['link']; ?>:</label>
                            <input type="url" name="link" id="link" class="form-control" value="<?php echo hesk_htmlspecialchars($default_values['link']); ?>" <?php if ($viewing) echo 'disabled'; ?>>
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
                    <div class="grid-4">
                        <div class="form-group">
                            <label for="model"><?php echo $hesklang['model']; ?>:<span class="important">*</span></label>
                            <input type="text" name="model" id="model" class="form-control" value="<?php echo hesk_htmlspecialchars($default_values['model']); ?>" required <?php if ($viewing) echo 'disabled'; ?>>
                        </div>
                        <div class="form-group">
                            <label for="wattage_w"><?php echo $hesklang['wattage_w']; ?>:<span class="important">*</span></label>
                            <input type="number" name="wattage_w" id="wattage_w" class="form-control" value="<?php echo hesk_htmlspecialchars($default_values['wattage_w']); ?>" min="1" required <?php if ($viewing) echo 'disabled'; ?>>
                        </div>
                        <div class="form-group">
                            <label for="stock"><?php echo $hesklang['stock']; ?>:</label>
                            <input type="number" name="stock" id="stock" class="form-control" value="<?php echo hesk_htmlspecialchars($default_values['stock']); ?>" <?php if ($viewing) echo 'disabled'; ?>>
                        </div>
                        <div class="form-group">
                            <label for="is_bivolt"><?php echo $hesklang['is_bivolt']; ?>:</label>
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
                    <div class="grid-3">
                        <div class="form-group">
                            <label for="model"><?php echo $hesklang['model']; ?>:<span class="important">*</span></label>
                            <input type="text" name="model" id="model" class="form-control" value="<?php echo hesk_htmlspecialchars($default_values['model']); ?>" required <?php if ($viewing) echo 'disabled'; ?>>
                        </div>
                        <div class="form-group">
                            <label for="size_gb"><?php echo $hesklang['size_gb']; ?>:<span class="important">*</span></label>
                            <input type="number" name="size_gb" id="size_gb" class="form-control" value="<?php echo hesk_htmlspecialchars($default_values['size_gb']); ?>" min="1" required <?php if ($viewing) echo 'disabled'; ?>>
                        </div>
                        <div class="form-group">
                            <label for="stock"><?php echo $hesklang['stock']; ?>:</label>
                            <input type="number" name="stock" id="stock" class="form-control" value="<?php echo hesk_htmlspecialchars($default_values['stock']); ?>" <?php if ($viewing) echo 'disabled'; ?>>
                        </div>
                    </div>
                    <div class="grid-3">
                        <div class="form-group">
                            <label for="speed_mhz"><?php echo $hesklang['speed_mhz']; ?>:</label>
                            <input type="number" name="speed_mhz" id="speed_mhz" class="form-control" value="<?php echo hesk_htmlspecialchars($default_values['speed_mhz']); ?>" <?php if ($viewing) echo 'disabled'; ?>>
                        </div>
                        <div class="form-group">
                            <label for="link"><?php echo $hesklang['link']; ?>:</label>
                            <input type="url" name="link" id="link" class="form-control" value="<?php echo hesk_htmlspecialchars($default_values['link']); ?>" <?php if ($viewing) echo 'disabled'; ?>>
                        </div>
                        <div class="form-group">
                            <label for="ram_type"><?php echo $hesklang['type']; ?>:<span class="important">*</span></label>
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
    $edit = hesk_POST('edit');
    $data      = [];
    $required  = []; 

    switch ($type) {
        case 'cpu':
            $data = [
                'model'   => hesk_input(hesk_POST('model')),
                'cores'   => intval(hesk_POST('cores', 0)),
                'threads' => intval(hesk_POST('threads', 0)),
                'ghz'     => hesk_POST('ghz'),
                'gpu'     => hesk_input(hesk_POST('gpu')),
                'link'    => hesk_input(hesk_POST('link')),
                'stock'   => intval(hesk_POST('stock', 0)),
            ];
            $required = ['model', 'cores', 'threads'];
            break;

        case 'disk':
            $data = [
                'model'     => hesk_input(hesk_POST('model')),
                'type'      => hesk_POST('disk_type'),
                'interface' => hesk_POST('interface'),
                'size_gb'   => intval(hesk_POST('size_gb', 0)),
                'link'      => hesk_input(hesk_POST('link')),
                'stock'     => intval(hesk_POST('stock', 0)),
            ];
            $required = ['model', 'size_gb', 'interface', 'type'];
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
                'model'          => hesk_input(hesk_POST('model')),
                'ram_slots'      => intval(hesk_POST('ram_slots', 0)),
                'ddr'            => hesk_POST('ddr'),
                'max_ram_gb'     => intval(hesk_POST('max_ram_gb', 0)),
                'network_iface'  => hesk_POST('network_iface'),
                'storage_ifaces' => $csv('storage_ifaces'),
                'chipset'        => hesk_input(hesk_POST('chipset')),
                'link'           => hesk_input(hesk_POST('link')),
                'stock'          => intval(hesk_POST('stock', 0)),
            ];
            $required = ['model', 'ddr', 'storage_ifaces'];
            break;

        case 'ps':
            $data = [
                'model'     => hesk_input(hesk_POST('model')),
                'wattage_w' => intval(hesk_POST('wattage_w', 0)),
                'is_bivolt' => isset($_POST['is_bivolt']) ? 1 : 0,
                'stock'     => intval(hesk_POST('stock', 0)),
            ];
            $required = ['model', 'wattage_w'];
            break;

        case 'ram':
            $data = [
                'model'     => hesk_input(hesk_POST('model')),
                'size_gb'   => intval(hesk_POST('size_gb')),
                'speed_mhz' => hesk_POST('speed_mhz') === '' ? null : intval(hesk_POST('speed_mhz')),
                'ram_type'  => hesk_POST('ram_type'),
                'link' => (hesk_POST('link') === '' ? null : hesk_input(hesk_POST('link'))),
                'stock'     => intval(hesk_POST('stock', 0)),
            ];
            $required = ['model', 'size_gb', 'ram_type'];
            break;
    }

    // Required fields for creation
    if (!$edit) {
        $data['is_active'] = 1;
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

    // Execute queries
    if ($edit) {
        $result = hesk_dbQuery("UPDATE `{$dbp}{$type}` SET $cols WHERE `id` = $orig_id");
        if (!$result) {
            die('SQL Error: ' . mysqli_error($GLOBALS['hesk_db_link']));
        }
        $msg = sprintf($hesklang['component_updated'], '<i>' . hesk_htmlspecialchars($data['model']) . '</i>');
    } else {
        $columns = [];
        $values = [];        
        foreach ($data as $col => $val) {
            $columns[] = "`$col`";
            
            if ($val === '' || $val === null) {
                $values[] = "NULL";
            } elseif (is_numeric($val)) {
                $values[] = $val;
            } else {
                $values[] = "'" . hesk_dbEscape($val) . "'";
            }
        }        
        $columns = implode(", ", $columns);
        $values = implode(", ", $values);

        $result = hesk_dbQuery("INSERT INTO `{$dbp}{$type}` ($columns) VALUES ($values)");
        
        if (!$result) {
            error_log('SQL Error: ' . mysqli_error($GLOBALS['hesk_db_link']));
            die('SQL Error: ' . mysqli_error($GLOBALS['hesk_db_link']));
        }
        $msg = sprintf($hesklang['component_added'], '<i>' . hesk_htmlspecialchars($data['model']) . '</i>');
    }
    
    hesk_cleanSessionVars('iserror');
    hesk_process_messages($msg,'manage_components.php','SUCCESS');
    exit;
}
require_once(HESK_PATH . 'inc/footer.inc.php');
?>