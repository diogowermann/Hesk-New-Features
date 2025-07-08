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

/* Code for the system to be able to differ if it's content from the original HESK */
define('IS_ASSET', 1);

/* Get all the required files and functions */
require(HESK_PATH . 'hesk_settings.inc.php');
require(HESK_PATH . 'inc/common.inc.php');
require(HESK_PATH . 'inc/admin_functions.inc.php');
require(HESK_PATH . 'inc/database_mysqli.inc.php');
hesk_load_database_functions();

hesk_session_start();
hesk_dbConnect();
hesk_isLoggedIn();
hesk_checkPermission('can_man_assets');

/* Get required database information for this feature */
// prefix for queries
$dbp = hesk_dbEscape($hesk_settings['db_pfix']);

$printers = hesk_dbQuery(
    "SELECT p.*, d.name AS department_name
     FROM `{$dbp}printers` p
     LEFT JOIN `{$dbp}departments` d ON p.department_id = d.id
     WHERE p.is_active = 1
     ORDER BY p.model"
);
/* Required database info collected */

/* Print header */
require_once(HESK_PATH . 'inc/header.inc.php');

/* Print main manage printers page */
require_once(HESK_PATH . 'inc/show_admin_nav.inc.php');

/* This will handle error, success and notice messages */
if (hesk_SESSION('iserror')) {
    hesk_handle_messages();
}
?>
<div class="main__content assets">
    <section class="assets__head">
        <h2><?php echo $hesklang['printers']; ?></h2>
        <a href="manage_printer.php" class="btn btn--blue-border" ripple="ripple">
            <?php echo $hesklang['add_new_printer']; ?>
        </a>
    </section>
    <div class="table-wrap">
        <table id="default-table" class="sortable-table table sindu-table">
            <thead>
                <tr>
                    <th><?php echo $hesklang['id']; ?></th>
                    <th><?php echo $hesklang['model']; ?></th>
                    <th><?php echo $hesklang['ip_address']; ?></th>
                    <th><?php echo $hesklang['local']; ?></th>
                    <th><?php echo $hesklang['department']; ?></th>
                    <th class="no-sort"><?php echo $hesklang['actions']; ?></th>
                </tr>
            </thead>
            <tbody>
                <?php if (hesk_dbNumRows($printers) > 0): ?>
                    <?php while ($printer = hesk_dbFetchAssoc($printers)): ?>
                    <tr>
                        <td><?php echo htmlspecialchars($printer['id']); ?></td>
                        <td><?php echo htmlspecialchars($printer['model']); ?></td>
                        <td><?php echo htmlspecialchars($printer['ip_address']); ?></td>
                        <td><?php echo $printer['is_local'] ? $hesklang['yes'] : $hesklang['no']; ?></td>
                        <td><?php echo htmlspecialchars($printer['department_name'] ?? $hesklang['none']); ?></td>
                        <td>
                            <div class="actions">
                                <a class="action-btn edit" href="manage_printer.php?do=edit&id=<?php echo $printer['id'] ?>"><svg class="icon icon-edit-ticket"><use xlink:href="../img/sprite.svg#icon-edit-ticket"></use></svg></a>
                                <a class="action-btn delete"
                                   href="manage_printer.php?do=delete&id=<?php echo $printer['id']; ?>"
                                   onclick="return confirm('<?php echo ($hesklang['delete_confirm']). ' ' . addslashes($printer['name']) . '?'; ?>')">
                                    <svg class="icon icon-delete"><use xlink:href="../img/sprite.svg#icon-delete"></use></svg>
                                </a>
                            </div>
                        </td>
                    </tr>
                    <?php endwhile; ?>
                <?php else: ?>
                    <tr>
                        <td colspan="6" class="no-data"><?php echo $hesklang['no_data_found']; ?></td>
                    </tr>
                <?php endif; ?>
            </tbody>
        </table>
    </div>
</div>
<?php
require_once(HESK_PATH . 'inc/footer.inc.php');
?>
