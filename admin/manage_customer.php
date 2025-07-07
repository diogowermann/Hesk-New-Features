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
$dbp = hesk_dbEscape($hesk_settings['db_pfix']);

// Are we editing or deleting?
$do = hesk_GET('do', '');
$editing = ($do === 'edit');
$deleting = ($do === 'delete');

// Prepare default values
$customer = [
    'name' => '',
    'email' => '',
    'department_id' => 0,
    'computer_mac' => ''
];

// If editing, load existing computer + its RAM/Disk links
$id = intval(hesk_GET('id', 0));
if ($editing) {
    $res = hesk_dbQuery("
        SELECT * 
        FROM `{$dbp}customers` 
        WHERE `id` = {$id} 
        LIMIT 1
    ");
    if (!$row = hesk_dbFetchAssoc($res)) {
        hesk_process_messages($hesklang['asset_not_found'], 'manage_customers.php');
        exit;
    }
    // overwrite defaults
    foreach ($row as $k => $v) {
        if (array_key_exists($k, $customer)) {
            $customer[$k] = $v;
        }
    }
} elseif ($deleting && ($id > 0)) {
    $res = hesk_dbQuery("
        UPDATE `{$dbp}customers` 
        SET `is_active` = 0 
        WHERE `id` = {$id} 
        LIMIT 1
    ");
    hesk_process_messages($hesklang['asset_deleted'], 'manage_customers.php', 'SUCCESS');
    exit;
}

// Fetch dropdown data
$computers = hesk_dbQuery("SELECT mac_address,name FROM `{$dbp}computers` WHERE is_active=1 AND customer_id IS NULL");
$departments = hesk_dbQuery("SELECT id,name FROM `{$dbp}departments` WHERE is_active=1");

// Handle form submit
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    try_save_customer();
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
        <form method="post" action="manage_customer.php" class="form grid-form">
            <input type="hidden" name="token" value="<?php hesk_token_echo(); ?>">
            <input type="hidden" name="original_id" value="<?php echo $id; ?>">

            <!-- Row 1: Email / Name -->
            <div class="grid-2">
                <div class="form-group">
                    <label for="name"><?php echo $hesklang['name']; ?>:<span class="important">*</span></label>
                    <input type="text" id="name" name="name" class="form-control" maxlength="100"
                        value="<?php echo hesk_htmlspecialchars($customer['name']); ?>" <?php echo $editing ? 'disabled' : ''; ?>>
                    <?php if ($editing): ?>
                        <input type="hidden" name="name" value="<?php echo $customer['name']; ?>">
                    <?php endif; ?>
                </div>
                <div class="form-group">
                    <label for="email"><?php echo $hesklang['email']; ?>:</label>
                    <input type="email" id="email" name="email" class="form-control" maxlength="100"
                        value="<?php echo hesk_htmlspecialchars($customer['email']); ?>">
                </div>
            </div>

            <!-- Row 2: Department / Computer -->
            <div class="grid-2">
                <div class="form-group">
                    <label for="department_id"><?php echo $hesklang['department']; ?>:</label>
                    <select name="department_id" id="department_id" class="form-control">
                        <option value="0"><?php echo $hesklang['none']; ?></option>
                        <?php while ($s = hesk_dbFetchAssoc($departments)): ?>
                            <option value="<?php echo $s['id']; ?>" <?php if ($s['id'] == $computer['department_id'])
                                   echo 'selected'; ?>>
                                <?php echo hesk_htmlspecialchars($s['name']); ?>
                            </option>
                        <?php endwhile; ?>
                    </select>
                </div>
                <div class="form-group">
                    <label for="computer_mac"><?php echo $hesklang['computer']; ?>:</label>
                    <select name="computer_mac" id="computer_mac" class="form-control">
                        <option value="0"><?php echo $hesklang['none']; ?></option>
                        <?php while ($c = hesk_dbFetchAssoc($computers)): ?>
                            <option value="<?php echo $c['mac_address']; ?>" <?php if ($c['mac_address'] == $customer['computer_mac'])
                                   echo 'selected'; ?>>
                                <?php echo hesk_htmlspecialchars($c['name']); ?>
                            </option>
                        <?php endwhile; ?>
                    </select>
                </div>
            </div>

            <?php if ($viewing): ?>
                <div class="grid-2">
                    <div class="form-group">
                        <label for="created_at"><?php echo $hesklang['created_at']; ?></label>
                        <input type="text" name="created_at" id="created_at" class="form-control"
                            value="<?php echo date('H:i:s - d/m/Y', strtotime($default_values['created_at'])); ?>" disabled>
                    </div>
                    <div class="form-group">
                        <label for="updated_at"><?php echo $hesklang['updated_at']; ?></label>
                        <input type="text" name="updated_at" id="updated_at" class="form-control"
                            value="<?php echo date('H:i:s - d/m/Y', strtotime($default_values['updated_at'])); ?>" disabled>
                    </div>
                </div>
            <?php endif;
            if (!$viewing):
            ?>
            <div class="grid-2 form-group">
                <button type="submit" class="btn btn-full btn--primary"><?php echo $editing ? $hesklang['save'] : $hesklang['create']; ?></button>
                <a class="btn btn--blue-border" href="manage_customers.php"><?php echo $hesklang['cancel'] ?></a>
            </div>
            <?php endif; ?>
        </form>
    </div>
</div>

<?php
function try_save_customer()
{
    global $dbp, $hesklang;
    hesk_token_check('POST');
    $orig_id = intval(hesk_POST('original_id', 0));
    $editing = ($orig_id > 0);
    $data = [
        'email' => hesk_input(hesk_POST('email')),
        'name' => hesk_input(hesk_POST('name')),
        'department_id' => intval(hesk_POST('department_id', 0)),
        'computer_mac' => strtolower(trim(hesk_POST('computer_mac')))
    ];

    // Required fields for creation
    if (!$editing && ($data['computer_mac'] == '' || $data['name'] == '' || $data['department_id'] == 0 || $data['email'] == '')) {
        $_SESSION['iserror'] = 1;
        hesk_process_messages($hesklang['fill_required'], 'NOREDIRECT');
    }

    // Build SET clause
    $cols = "
        `name`          = '" . hesk_dbEscape($data['name']) . "',
        `email`         = '" . hesk_dbEscape($data['email']) . "',
        `department_id` = " . ($data['department_id'] ? $data['department_id'] : 'NULL') . ",
        `computer_mac`  = '" . hesk_dbEscape($data['computer_mac']) . "'
    ";

    if ($orig_id) {
        // Update
        hesk_dbQuery("UPDATE `{$dbp}customers` SET {$cols} WHERE `id` = {$orig_id}");
        $msg = sprintf($hesklang['customer_updated'], '<i>' . hesk_htmlspecialchars($data['name']) . '</i>');
    } else {
        // Insert
        hesk_dbQuery("INSERT INTO `{$dbp}customers` SET {$cols}");
        $msg = sprintf($hesklang['customer_added'], '<i>' . hesk_htmlspecialchars($data['name']) . '</i>');
    }

    hesk_cleanSessionVars('iserror');
    hesk_process_messages($msg, 'manage_customers.php', 'SUCCESS');
    exit;
}

require_once(HESK_PATH . 'inc/footer.inc.php');