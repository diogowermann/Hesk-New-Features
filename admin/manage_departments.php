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

// Handle department creation
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['new_department_name'])) {
    $new_name = hesk_dbEscape(trim($_POST['new_department_name']));
    if ($new_name !== '') {
        hesk_dbQuery("INSERT INTO `{$dbp}departments` (name) VALUES ('{$new_name}')");
        header('Location: manage_departments.php');
    }
}

// Handle department deactivation
if (isset($_GET['deactivate']) && is_numeric($_GET['deactivate'])) {
    $dept_id = intval($_GET['deactivate']);
    hesk_dbQuery("UPDATE `{$dbp}departments` SET is_active = 0 WHERE id = {$dept_id}");
    header('Location: manage_departments.php');
}

$departments = hesk_dbQuery("SELECT * FROM `{$dbp}departments` WHERE `is_active` = 1 ORDER BY name");
/* Required database info collected */

/* Print header */
require_once(HESK_PATH . 'inc/header.inc.php');

/* Print main manage users page */
require_once(HESK_PATH . 'inc/show_admin_nav.inc.php');

/* This will handle error, success and notice messages */
if (hesk_SESSION('iserror')) {
    hesk_handle_messages();
}
?>
<div class="main__content assets">
    <section class="assets__head">
        <h2><?php echo $hesklang['departments']; ?></h2>
        <button class="btn btn--blue-border" onclick="toggleModal()"><?php echo $hesklang['add_new_department'] ?? 'Add New Department'; ?></button>
    </section>

    <div class="table-wrap">
        <div class="table">
            <table class="table sindu-table">
                <thead>
                    <tr>
                        <th><?php echo $hesklang['id']; ?></th>
                        <th><?php echo $hesklang['name']; ?></th>
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
                                <div class="actions">
                                    <a class="action-btn delete"
                                       href="manage_departments.php?deactivate=<?php echo (int)$dept['id']; ?>"
                                       onclick="return confirm('<?php echo ($hesklang['delete_confirm']). ' ' . addslashes($dept['name']) . '?'; ?>')">
                                        <svg class="icon icon-delete"><use xlink:href="../img/sprite.svg#icon-delete"></use></svg>
                                    </a>
                                </div>
                            </td>
                        </tr>
                        <?php endwhile; ?>
                    <?php else: ?>
                        <tr>
                            <td colspan="4" class="no-data"><?php echo $hesklang['no_data_found']; ?></td>
                        </tr>
                    <?php endif; ?>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Modal for adding department -->
    <div class="modal" id="addDeptModal" onclick="modalBgClick(event)">
        <div class="modal__body">
            <span class="modal__close" onclick="toggleModal()">
                <svg class="icon icon-close"><use xlink:href="../img/sprite.svg#icon-close"></use></svg>
            </span>
            <h3><?php echo $hesklang['add_new_department']; ?></h3>
            <form method="post" autocomplete="off" class="form">
                <div class="form-group">
                    <label for="new_department_name"><?php echo $hesklang['name'] ?? 'Name'; ?></label>
                    <input type="text" class="form-control" id="new_department_name" name="new_department_name" required maxlength="100" autofocus>
                </div>
                <div class="modal__buttons">
                    <button type="submit" class="btn btn--blue-border btn--primary"><?php echo $hesklang['save']; ?></button>
                    <button type="button" class="btn btn--delete" onclick="toggleModal()"><?php echo $hesklang['cancel']; ?></button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
function toggleModal() {
    var modal = document.getElementById('addDeptModal');
    modal.style.display = (modal.style.display === 'block') ? 'none' : 'block';
}
function modalBgClick(e) {
    if (e.target.classList.contains('modal')) {
        toggleModal();
    }
}
</script>
<?php
require_once(HESK_PATH . 'inc/footer.inc.php');
?>
