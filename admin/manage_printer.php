<?php
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

// Table prefix
$dbp = hesk_dbEscape($hesk_settings['db_pfix']);

// Actions: edit, view, delete
$do = hesk_GET('do', '');
$editing = ($do === 'edit');
$viewing = ($do === 'view'); 
$deleting = ($do === 'delete'); 

// Default printer values
$printer = [
    'model' => '',
    'ip_address' => '',
    'computer_id' => 0,
    'is_local' => 1,
    'department_id' => 0,
    'created_at' => '',
    'updated_at' => ''
];

// Load printer if editing/viewing/deleting
$printer_id = intval(hesk_GET('id', 0));
if ($editing || $viewing) {
    $res = hesk_dbQuery("
        SELECT * 
        FROM `{$dbp}printers` 
        WHERE `id` = {$printer_id} 
        LIMIT 1
    ");
    if (!$row = hesk_dbFetchAssoc($res)) {
        hesk_process_messages($hesklang['printer_not_found'], 'manage_printers.php');
        exit;
    }
    $printer = $row;
} elseif ($deleting && ($printer_id > 0)) {
    hesk_dbQuery("
        UPDATE `{$dbp}printers` 
        SET `is_active` = 0 
        WHERE `id` = {$printer_id} 
        LIMIT 1
    ");
    hesk_process_messages($hesklang['printer_deleted'], 'manage_printers.php', 'SUCCESS');
    exit;
}

// Fetch departments
$departments = hesk_dbQuery("SELECT id,name FROM `{$dbp}departments` WHERE is_active=1");

// Fetch available computers (add this block)
$available_computers = array();
if (!$viewing) {
    $exclude_printer_id = $editing ? $printer_id : 0;
    $current_computer_id = $printer['computer_id'] ?? 0;

    $sql = "
        SELECT c.id, c.name 
        FROM `{$dbp}computers` c
        INNER JOIN `{$dbp}computers_mb` mb ON c.mb_id = mb.id
        WHERE c.is_active=1 
        AND mb.network_iface IN ('Ethernet', 'Ethernet+WiFi')
        AND (
            c.id NOT IN (
                SELECT computer_id 
                FROM `{$dbp}printers` 
                WHERE is_active=1 
                AND computer_id != 0 
                AND id != {$exclude_printer_id}
            )
            OR c.id = {$current_computer_id}
        )
    ";
    $res = hesk_dbQuery($sql);
    while ($row = hesk_dbFetchAssoc($res)) {
        $available_computers[] = $row;
    }
}

// Handle form submit
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    try_save_printer();
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
            <?php echo $editing ? $hesklang['edit_printer'] : $hesklang['create_printer']; ?>
        </h2>
    </section>

    <div class="table-wrap">
        <form method="post" action="manage_printer.php" class="form grid-form">
            <input type="hidden" name="token" value="<?php hesk_token_echo(); ?>">
            <input type="hidden" name="original_id" value="<?php echo $printer_id; ?>">

            <!-- Printer Details -->
            <div class="grid-2">
                <div class="form-group">
                    <label for="model"><?php echo $hesklang['model']; ?><span class="important">*</span></label>
                    <input type="text" id="model" name="model" class="form-control" maxlength="100" 
                        value="<?php echo hesk_htmlspecialchars($printer['model']); ?>" 
                        <?php echo $viewing ? 'disabled' : ''; ?>>
                </div>
                <div class="form-group">
                    <label for="department_id"><?php echo $hesklang['department']; ?></label>
                    <select name="department_id" id="department_id" class="form-control" <?php echo $viewing ? 'disabled' : ''; ?>>
                        <option value="0"><?php echo $hesklang['none']; ?></option>
                        <?php while ($s = hesk_dbFetchAssoc($departments)): ?>
                        <option value="<?php echo $s['id']; ?>" <?php if ($s['id'] == $printer['department_id']) echo 'selected'; ?>>
                            <?php echo hesk_htmlspecialchars($s['name']); ?>
                        </option>
                        <?php endwhile; ?>
                    </select>
                </div>
            </div>

            <div class="grid-2">
                <div class="form-group">
                    <label><?php echo $hesklang['printer_type']; ?></label>
                    <div class="flex-options">
                        <label><input type="radio" name="is_local" value="1" 
                            <?php echo $printer['is_local'] ? 'checked' : ''; ?> 
                            <?php echo $viewing ? 'disabled' : ''; ?>> <?php echo $hesklang['local']; ?></label>
                        <label><input type="radio" name="is_local" value="0" 
                            <?php echo !$printer['is_local'] ? 'checked' : ''; ?> 
                            <?php echo $viewing ? 'disabled' : ''; ?>> <?php echo $hesklang['network']; ?></label>
                    </div>
                </div>
                
                <!-- Network Printer Field (IP Address) -->
                <div class="form-group" id="ip_address_field" style="<?php echo ($printer['is_local'] ? 'display:none;' : ''); ?>">
                    <label for="ip_address"><?php echo $hesklang['ip_address']; ?></label>
                    <input type="text" id="ip_address" name="ip_address" class="form-control" maxlength="15" 
                        placeholder="192.168.0.90-99"
                        value="<?php echo hesk_htmlspecialchars($printer['ip_address']); ?>" 
                        <?php echo $viewing ? 'disabled' : ''; ?>>
                </div>
                
                <!-- Local Printer Field (Computer Dropdown) -->
                <div class="form-group" id="computer_field" style="<?php echo (!$printer['is_local'] ? 'display:none;' : ''); ?>">
                    <label for="computer_id"><?php echo $hesklang['computer']; ?></label>
                    <select name="computer_id" id="computer_id" class="form-control" <?php echo $viewing ? 'disabled' : ''; ?>>
                        <option value="0"><?php echo $hesklang['none']; ?></option>
                        <?php foreach ($available_computers as $computer): ?>
                        <option value="<?php echo $computer['id']; ?>" 
                            <?php echo ($printer['computer_id'] == $computer['id']) ? 'selected' : ''; ?>>
                            <?php echo hesk_htmlspecialchars($computer['name']); ?>
                        </option>
                        <?php endforeach; ?>
                    </select>
                </div>
            </div>

            <!-- Dates -->
             <?php if ($viewing): ?>
                <div class="grid-2">
                    <div class="form-group">
                        <label for="created_at"><?php echo $hesklang['created_at']; ?>:</label>
                        <input type="text" class="form-control" disabled 
                            value="<?php echo date('H:i:s - d/m/Y', strtotime($printer['created_at'])); ?>">
                    </div>
                    <div class="form-group">
                        <label for="updated_at"><?php echo $hesklang['updated_at']; ?>:</label>
                        <input type="text" class="form-control" disabled 
                            value="<?php echo date('H:i:s - d/m/Y', strtotime($printer['updated_at'])); ?>">
                    </div>
                </div>
            <?php endif; ?>

            <!-- Submit Button -->
            <?php if (!$viewing): ?>
            <div class="form-group">
                <button type="submit" class="btn btn-full" ripple="ripple">
                    <?php echo $editing ? $hesklang['save'] : $hesklang['create']; ?>
                </button>
            </div>
            <?php endif; 
            if (!$viewing): ?>
                <script>
                document.addEventListener('DOMContentLoaded', function() {
                    const localRadio = document.querySelector('input[name="is_local"][value="1"]');
                    const networkRadio = document.querySelector('input[name="is_local"][value="0"]');
                    const computerField = document.getElementById('computer_field');
                    const ipAddressField = document.getElementById('ip_address_field');

                    function toggleFields() {
                        if (localRadio.checked) {
                            computerField.style.display = 'block';
                            ipAddressField.style.display = 'none';
                        } else {
                            computerField.style.display = 'none';
                            ipAddressField.style.display = 'block';
                        }
                    }

                    localRadio.addEventListener('change', toggleFields);
                    networkRadio.addEventListener('change', toggleFields);
                });
                </script>
            <?php endif; ?>
        </form>
    </div>
</div>

<?php
function try_save_printer() {
    global $dbp, $hesklang;
    hesk_token_check('POST');
    
    $orig_id = intval(hesk_POST('original_id', 0));
    $editing = ($orig_id > 0);
    
    $is_local = intval(hesk_POST('is_local', 1));
    $computer_id = $is_local ? intval(hesk_POST('computer_id', 0)) : 0;

    $data = [
        'model' => hesk_input(hesk_POST('model')),
        'ip_address' => hesk_input(hesk_POST('ip_address')),
        'department_id' => intval(hesk_POST('department_id', 0)),
        'is_local' => $is_local,
        'computer_id' => $computer_id,
    ];


    // Validation
    if (empty($data['model'])) {
        $_SESSION['iserror'] = 1;
        hesk_process_messages($hesklang['p_name_req'], 'NOREDIRECT');
    }

    // IP validation
    if ($data['ip_address'] && !filter_var($data['ip_address'], FILTER_VALIDATE_IP)) {
        $_SESSION['iserror'] = 1;
        hesk_process_messages($hesklang['invalid_ip'], 'NOREDIRECT');
    }

    if ($is_local) {
        // Check computer is selected
        if ($computer_id == 0) {
            $_SESSION['iserror'] = 1;
            hesk_process_messages($hesklang['select_computer'], 'NOREDIRECT');
        }
        // Check computer exists and is valid
        elseif ($computer_id > 0) {
            $res = hesk_dbQuery("
                SELECT c.id 
                FROM `{$dbp}computers` c
                INNER JOIN `{$dbp}computers_mb` mb ON c.mb_id = mb.id
                WHERE c.id = {$computer_id} 
                AND c.is_active=1 
                AND mb.network_iface IN ('Ethernet', 'Ethernet+WiFi')
            ");
            if (hesk_dbNumRows($res) == 0) {
                $_SESSION['iserror'] = 1;
                hesk_process_messages($hesklang['invalid_computer'], 'NOREDIRECT');
            }
            // Check computer not already assigned
            else {
                $res = hesk_dbQuery("
                    SELECT id 
                    FROM `{$dbp}printers` 
                    WHERE computer_id = {$computer_id} 
                    AND is_active=1 
                    AND id != {$orig_id}
                ");
                if (hesk_dbNumRows($res) > 0) {
                    $_SESSION['iserror'] = 1;
                    hesk_process_messages($hesklang['computer_already_has_printer'], 'NOREDIRECT');
                }
            }
        }
    }

    if (isset($_SESSION['iserror'])) {
        header('Location: manage_printer.php'.($orig_id ? '?id='.$orig_id : ''));
        exit;
    }

    // Build SQL
    $computer_id_value = ($data['computer_id'] > 0) ? $data['computer_id'] : 'NULL';

    $sql_set = "
        `model` = '".hesk_dbEscape($data['model'])."',
        `ip_address` = '".hesk_dbEscape($data['ip_address'])."',
        `department_id` = ".($data['department_id'] ? $data['department_id'] : 'NULL').",
        `is_local` = {$data['is_local']},
        `computer_id` = $computer_id_value
    ";

    if ($editing) {
        hesk_dbQuery("UPDATE `{$dbp}printers` SET {$sql_set} WHERE `id` = {$orig_id}");
        $msg = sprintf($hesklang['printer_updated'], '<i>'.hesk_htmlspecialchars($data['model']).'</i>');
    } else {
        hesk_dbQuery("INSERT INTO `{$dbp}printers` SET {$sql_set}");
        $msg = sprintf($hesklang['printer_added'], '<i>'.hesk_htmlspecialchars($data['model']).'</i>');
    }

    hesk_cleanSessionVars('iserror');
    hesk_process_messages($msg, 'manage_printers.php', 'SUCCESS');
    exit;
}

require_once(HESK_PATH . 'inc/footer.inc.php');