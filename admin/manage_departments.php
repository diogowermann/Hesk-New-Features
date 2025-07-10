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

// Pre-fetch active customers and printers by department
$customers_by_dept = array();
$res = hesk_dbQuery("SELECT id, name, department_id FROM `{$dbp}customers` WHERE is_active=1");
while ($row = hesk_dbFetchAssoc($res)) {
    $dept_id = $row['department_id'];
    if (!isset($customers_by_dept[$dept_id])) {
        $customers_by_dept[$dept_id] = array();
    }
    $customers_by_dept[$dept_id][] = $row;
}

$printers_by_dept = array();
$res = hesk_dbQuery("SELECT id, model, department_id FROM `{$dbp}printers` WHERE is_active=1");
while ($row = hesk_dbFetchAssoc($res)) {
    $dept_id = $row['department_id'];
    if (!isset($printers_by_dept[$dept_id])) {
        $printers_by_dept[$dept_id] = array();
    }
    $printers_by_dept[$dept_id][] = $row;
}

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
    <style>
        .tooltip {
            position: relative;
            display: inline-block;
            cursor: help;
            margin-left: 5px;
        }
        .tooltip .tooltiptext {
            visibility: hidden;
            width: 200px;
            background-color: #555;
            color: #fff;
            text-align: center;
            border-radius: 6px;
            padding: 5px;
            position: absolute;
            z-index: 1000;
            bottom: 125%;
            left: 50%;
            margin-left: -100px;
            opacity: 0;
            transition: opacity 0.3s;
        }
        .tooltip .tooltiptext::after {
            content: "";
            position: absolute;
            top: 100%;
            left: 50%;
            margin-left: -5px;
            border-width: 5px;
            border-style: solid;
            border-color: #555 transparent transparent transparent;
        }
        .tooltip:hover .tooltiptext {
            visibility: visible;
            opacity: 1;
        }
        .tooltip-icon {
            display: inline-block;
            width: 16px;
            height: 16px;
            background: #ccc;
            border-radius: 50%;
            text-align: center;
            line-height: 16px;
            font-size: 12px;
        }
    </style>
    
    <section class="assets__head">
        <h2><?php echo $hesklang['departments']; ?></h2>
        <button class="btn btn--blue-border" onclick="toggleModal()"><?php echo $hesklang['add_new_department']; ?></button>
    </section>

    <div class="table-wrap">
        <div class="table">
            <table class="table sindu-table">
                <thead>
                    <tr>
                        <th><?php echo $hesklang['id']; ?></th>
                        <th><?php echo $hesklang['name']; ?></th>
                        <th><?php echo $hesklang['customers']; ?></th>
                        <th><?php echo $hesklang['printers']; ?></th>
                        <th><?php echo $hesklang['actions']; ?></th>
                    </tr>
                </thead>
                <tbody>
                    <?php if (hesk_dbNumRows($departments) > 0): ?>
                        <?php while ($dept = hesk_dbFetchAssoc($departments)): 
                            $dept_id = $dept['id'];
                            $customer_list = isset($customers_by_dept[$dept_id]) ? $customers_by_dept[$dept_id] : array();
                            $printer_list = isset($printers_by_dept[$dept_id]) ? $printers_by_dept[$dept_id] : array();
                            $customer_count = count($customer_list);
                            $printer_count = count($printer_list);
                            
                            // Prepare tooltip content
                            $customer_tooltip = '';
                            foreach ($customer_list as $customer) {
                                $customer_tooltip .= htmlspecialchars($customer['name']) . '<br>';
                            }
                            
                            $printer_tooltip = '';
                            foreach ($printer_list as $printer) {
                                $printer_tooltip .= htmlspecialchars($printer['model']) . '<br>';
                            }
                        ?>
                        <tr>
                            <td><?php echo htmlspecialchars($dept['id']); ?></td>
                            <td><?php echo htmlspecialchars($dept['name']); ?></td>
                            <td>
                                <?php echo $customer_count; ?>
                                <?php if ($customer_count > 0): ?>
                                <div class="tooltype right out-close">
                                    <svg class="icon icon-info">
                                        <use xlink:href="<?php echo HESK_PATH; ?>img/sprite.svg#icon-info"></use>
                                    </svg>
                                    <div class="tooltype__content">
                                        <div class="tooltype__wrapper">
                                            <?php echo $customer_tooltip; ?>
                                        </div>
                                    </div>
                                </div>
                                <?php endif; ?>
                            </td>
                            <td>
                                <?php echo $printer_count; ?>
                                <?php if ($printer_count > 0): ?>
                                <div class="tooltype right out-close">
                                    <svg class="icon icon-info">
                                        <use xlink:href="<?php echo HESK_PATH; ?>img/sprite.svg#icon-info"></use>
                                    </svg>
                                    <div class="tooltype__content">
                                        <div class="tooltype__wrapper">
                                            <?php echo $printer_tooltip; ?>
                                        </div>
                                    </div>
                                </div>
                                <?php endif; ?>
                            </td>
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
                            <td colspan="5" class="no-data"><?php echo $hesklang['no_data_found']; ?></td>
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
                    <label for="new_department_name"><?php echo $hesklang['name']; ?></label>
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