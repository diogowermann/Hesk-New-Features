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

// prefix for queries
$dbp = hesk_dbEscape($hesk_settings['db_pfix']);

$departments = hesk_dbQuery("SELECT id, name, is_active FROM `{$dbp}departments` ORDER BY name");

require_once(HESK_PATH . 'inc/header.inc.php');
require_once(HESK_PATH . 'inc/show_admin_nav.inc.php');

if (hesk_SESSION('iserror')) {
    hesk_handle_messages();
}
?>
<div class="main__content assets">
    <section class="assets__head">
        <h2><?php echo $hesklang['departments'] ?? 'Departments'; ?></h2>
        <a class="btn btn--blue-border" href="manage_department.php"><?php echo $hesklang['add_new_department']; ?></a>
    </section>

    <div class="table-wrap">
        <div class="table">
            <table class="table sindu-table">
                <thead>
                    <tr>
                        <th><?php echo $hesklang['id']; ?></th>
                        <th><?php echo $hesklang['name']; ?></th>
                        <th><?php echo $hesklang['computers']; ?></th>
                        <th><?php echo $hesklang['printers']; ?></th>
                        <th><?php echo $hesklang['actions']; ?></th>
                    </tr>
                </thead>
                <tbody>
                    <?php if (hesk_dbNumRows($departments) > 0): ?>
                        <?php while ($dept = hesk_dbFetchAssoc($departments)): ?>
                        <tr>
                            <td><?php echo htmlspecialchars($dept['id']); ?></td>
                            <td><?php echo htmlspecialchars($dept['name']); ?></td>
                            <td>
                                <?php echo $dept['is_active'] ? ($hesklang['active'] ?? 'Active') : ($hesklang['inactive'] ?? 'Inactive'); ?>
                            </td>
                            <td>
                                <div class="actions">
                                    <a class="action-btn edit" href="manage_department.php?do=edit&id=<?php echo $dept['id'] ?>"><svg class="icon icon-edit-ticket"><use xlink:href="../img/sprite.svg#icon-edit-ticket"></use></svg></a>
                                    <a class="action-btn delete" href="manage_department.php?do=delete&id=<?php echo $dept['id'] ?>" onclick="return confirm('<?php echo ($hesklang['delete_confirm'] ?? 'Delete'). ' ' . addslashes($dept['name']) . '?'; ?>')"><svg class="icon icon-delete"><use xlink:href="../img/sprite.svg#icon-delete"></use></svg></a>
                                </div>
                            </td>
                        </tr>
                        <?php endwhile; ?>
                    <?php else: ?>
                        <tr>
                            <td colspan="5" class="no-data"><?php echo $hesklang['no_data_found'] ?? 'No data found.'; ?></td>
                        </tr>
                    <?php endif; ?>
                </tbody>
            </table>
        </div>
    </div>
</div>
<?php
require_once(HESK_PATH . 'inc/footer.inc.php');
?>
