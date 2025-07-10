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
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['model'])) {
    $model = hesk_dbEscape(trim($_POST['model']));
    $update_hz = isset($_POST['update_hz']) ? intval($_POST['update_hz']) : 0;
    $size_in = isset($_POST['size_in']) ? floatval($_POST['size_in']) : 0.0;
    $customer_id = isset($_POST['customer_id']) ? intval($_POST['customer_id']) : 0;
    $customer_sql = ($customer_id === 0) ? 'NULL' : $customer_id;

    if ($model !== '') {
        hesk_dbQuery("INSERT INTO `{$dbp}monitors` (model, update_hz, size_in, customer_id) 
                      VALUES ('{$model}', {$update_hz}, {$size_in}, {$customer_sql})");
        header('Location: manage_monitors.php');
    }
}

// Handle department deactivation
if (isset($_GET['deactivate']) && is_numeric($_GET['deactivate'])) {
    $monitor_id = intval($_GET['deactivate']);
    hesk_dbQuery("UPDATE `{$dbp}monitors` SET is_active = 0 WHERE id = {$monitor_id}");
    header('Location: manage_monitors.php');
}

$monitors = hesk_dbQuery("SELECT m.*, c.name AS customer_name 
    FROM `{$dbp}monitors` AS m
    LEFT JOIN `{$dbp}customers` AS c ON m.customer_id = c.id
    WHERE m.is_active = 1 
    ORDER BY m.model
");/* Required database info collected */

// Fetch dropdown data
$customers   = hesk_dbQuery("SELECT id,name FROM `{$dbp}customers`    WHERE is_active=1");

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
        <h2><?php echo $hesklang['monitors']; ?></h2>
        <button class="btn btn--blue-border" onclick="toggleModal()"><?php echo $hesklang['add_new_monitor']; ?></button>
    </section>

    <div class="table-wrap">
        <div class="table">
            <table class="table sindu-table">
                <thead>
                    <tr>
                        <th><?php echo $hesklang['id']; ?></th>
                        <th><?php echo $hesklang['model']; ?></th>
                        <th><?php echo $hesklang['customer']; ?></th>
                        <th><?php echo $hesklang['update_hz']; ?></th>
                        <th><?php echo $hesklang['size_in']; ?></th>
                        <th><?php echo $hesklang['actions']; ?></th>
                    </tr>
                </thead>
                <tbody>
                    <?php if (hesk_dbNumRows($monitors) > 0): ?>
                        <?php while ($m = hesk_dbFetchAssoc($monitors)): ?>
                        <tr>
                            <td><?php echo htmlspecialchars($m['id']); ?></td>
                            <td><?php echo htmlspecialchars($m['model']); ?></td>
                            <td><?php echo htmlspecialchars($m['customer_name'])?: $hesklang['none']; ?></td>
                            <td><?php echo htmlspecialchars($m['update_hz'])?: $hesklang['none'];; ?></td>
                            <td><?php echo htmlspecialchars($m['size_in'])?: $hesklang['none'];; ?></td>
                            <td>
                                <div class="actions">
                                    <a class="action-btn delete"
                                       href="manage_monitors.php?deactivate=<?php echo (int)$m['id']; ?>"
                                       onclick="return confirm('<?php echo ($hesklang['delete_confirm']). ' ' . addslashes($m['model']) . '?'; ?>')">
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

    <!-- Modal for adding department -->
    <div class="modal" id="addMonitorModal" onclick="modalBgClick(event)">
        <div class="modal__body">
            <span class="modal__close" onclick="toggleModal()">
                <svg class="icon icon-close"><use xlink:href="../img/sprite.svg#icon-close"></use></svg>
            </span>
            <h3><?php echo $hesklang['add_new_monitor']; ?></h3>
            <form method="post" autocomplete="off" class="form">
                <div class="form-group">
                    <label for="model"><?php echo $hesklang['model']; ?><span class="important">*</span></label>
                    <input type="text" class="form-control" id="model" name="model" required maxlength="100" autofocus>
                </div>
                <div class="grid-2">
                    <div class="form-group">
                        <label><?php echo $hesklang['update_hz']; ?>:</label>
                        <input type="number" name="update_hz" id="update_hz" class="form-control" min="0" step="1">
                    </div>
                    <div class="form-group">
                        <label><?php echo $hesklang['size_in']; ?>:</label>
                        <input type="number" name="size_in" id="size_in" class="form-control" min="0" step="0.1">
                    </div>
                </div>
                <div class="form-group">
                    <label for="customer_id"><?php echo $hesklang['customer']; ?>:</label>
                    <select name="customer_id" id="customer_id" class="form-control">
                        <option value="0"><?php echo $hesklang['none']; ?></option>
                        <?php while ($u = hesk_dbFetchAssoc($customers)): ?>
                        <option value="<?php echo $u['id']; ?>">
                            <?php echo hesk_htmlspecialchars($u['name']); ?>
                        </option>
                        <?php endwhile; ?>
                    </select>
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
    var modal = document.getElementById('addMonitorModal');
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
