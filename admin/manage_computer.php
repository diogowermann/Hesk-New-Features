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
$do  = hesk_GET('do', '');
$editing = ($do === 'edit');
$viewing = ($do === 'view'); 
$deleting = ($do === 'delete'); 

// Prepare default values
$computer = [
    'asset_tag'      => '',
    'mac_address'    => '',
    'name'           => '',
    'cpu_id'         => 0,
    'mb_id'          => 0,
    'ps_id'          => 0,
    'os_name'        => '',
    'os_version'     => '',
    'purchase_date'  => '',
    'warranty_until' => '',
    'customer_id'    => 0,
    'department_id'  => 0,
    'is_internal'    => 1,
    'is_desktop'     => 1,
    'is_secure'      => 1,
    'ram_ids'        => [],
    'disk_ids'       => [],
    'created_at'     => '',
    'updated_at'     => '',
];

// If editing, load existing computer + its RAM/Disk links
$comp_id  = intval(hesk_GET('id', 0));
if ($editing || $viewing) {
    $res = hesk_dbQuery("
        SELECT * 
        FROM `{$dbp}computers` 
        WHERE `id` = {$comp_id} 
        LIMIT 1
    ");
    if (!$row = hesk_dbFetchAssoc($res)) {
        hesk_process_messages($hesklang['asset_not_found'], 'manage_computers.php');
        exit;
    }
    // overwrite defaults
    foreach ($row as $k => $v) {
        if (array_key_exists($k, $computer)) {
            $computer[$k] = $v;
        }
    }
    // load RAM links
    $ram_res = hesk_dbQuery("
        SELECT `ram_id` 
        FROM `{$dbp}computer_has_ram` 
        WHERE `computer_id` = {$comp_id}
    ");
    while ($r = hesk_dbFetchAssoc($ram_res)) {
        $computer['ram_ids'][] = $r['ram_id'];
    }
    // load Disk links
    $disk_res = hesk_dbQuery("
        SELECT `disk_id` 
        FROM `{$dbp}computer_has_disk` 
        WHERE `computer_id` = {$comp_id}
    ");
    while ($d = hesk_dbFetchAssoc($disk_res)) {
        $computer['disk_ids'][] = $d['disk_id'];
    }
} elseif ($deleting && ($comp_id > 0)) {
    $res = hesk_dbQuery("
        UPDATE `{$dbp}computers` 
        SET `is_active` = 0 
        WHERE `id` = {$comp_id} 
        LIMIT 1
    ");
    hesk_process_messages($hesklang['asset_deleted'], 'manage_computers.php', 'SUCCESS');
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['fetch_components']) && $_POST['fetch_components'] === '1') {
    $mb_id = intval($_POST['mb_id']);
    $mb_q  = hesk_dbQuery("
        SELECT ddr, storage_ifaces
        FROM `{$dbp}computers_mb`
        WHERE id = {$mb_id} LIMIT 1
    ");
    $mb = hesk_dbFetchAssoc($mb_q);

    $ddr     = hesk_dbEscape($mb['ddr']);
    $ifs     = array_map('trim', explode(',', $mb['storage_ifaces']));
    $ifsEsc  = array_map(fn($i)=> "'".hesk_dbEscape($i)."'", $ifs);
    $ifsList = implode(',', $ifsEsc);

    $ramQ = hesk_dbQuery("
        SELECT id, model, size_gb, speed_mhz 
        FROM `{$dbp}computers_ram` 
        WHERE is_active=1 
          AND ram_type='{$ddr}'
    ");
    $ram = [];
    while ($row = hesk_dbFetchAssoc($ramQ)) {
        $ram[] = $row;
    }

    $diskQ = hesk_dbQuery("
        SELECT id, model, size_gb, type 
        FROM `{$dbp}computers_disk` 
        WHERE is_active=1 
          AND `interface` IN ({$ifsList})
    ");
    $disk = [];
    while ($row = hesk_dbFetchAssoc($diskQ)) {
        $disk[] = $row;
    }

    header('Content-Type: application/json');
    echo json_encode(['ram' => $ram, 'disk' => $disk]);
    exit;
}

// Fetch dropdown data
$customers   = hesk_dbQuery("SELECT id,name FROM `{$dbp}customers`    WHERE is_active=1");
$departments = hesk_dbQuery("SELECT id,name FROM `{$dbp}departments`  WHERE is_active=1");
$cpus        = hesk_dbQuery("SELECT id,model FROM `{$dbp}computers_cpu` WHERE is_active=1");
$mbs         = hesk_dbQuery("SELECT id,model FROM `{$dbp}computers_mb`  WHERE is_active=1");
$pss         = hesk_dbQuery("SELECT id,model,wattage_w FROM `{$dbp}computers_ps` WHERE is_active=1");
$rams        = hesk_dbQuery("SELECT id,model,size_gb,ram_type FROM `{$dbp}computers_ram` WHERE is_active=1");
$disks       = hesk_dbQuery("SELECT id,model,size_gb,type FROM `{$dbp}computers_disk` WHERE is_active=1");

// Handle form submit
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    try_save_computer();
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
        <form method="post" action="manage_computer.php" class="form grid-form">
            <input type="hidden" name="token" value="<?php hesk_token_echo(); ?>">
            <input type="hidden" name="original_id" value="<?php echo $comp_id; ?>">

            <!-- Row 1: Asset Tag / Name -->
            <div class="grid-2">
            <div class="form-group">
                <label for="asset_tag"><?php echo $hesklang['asset_tag']; ?>:</label>
                <input type="text" id="asset_tag" name="asset_tag" class="form-control" maxlength="50" value="<?php echo hesk_htmlspecialchars($computer['asset_tag']); ?>" <?php echo ($editing || $viewing) ? 'disabled' : ''; ?>>
                <?php if ($editing || $viewing): ?>
                    <input type="hidden" name="asset_tag" value="<?php echo $computer['asset_tag']; ?>">
                <?php endif; ?>
            </div>
            <div class="form-group">
                <label for="name"><?php echo $hesklang['computer_name']; ?>:<span class="important">*</span></label>
                <input type="text" id="name" name="name" class="form-control" maxlength="100" value="<?php echo hesk_htmlspecialchars($computer['name']); ?>" <?php echo $viewing ? 'disabled' : ''; ?>>
            </div>
            </div>

            <!-- Row 2: MAC / OS -->
            <div class="grid-3">
            <div class="form-group">
                <label for="mac"><?php echo $hesklang['mac_address']; ?>:<span class="important">*</span></label>
                <input type="text" id="mac" name="mac" class="form-control" maxlength="17" placeholder="00:1B:44:11:3A:B7" value="<?php echo hesk_htmlspecialchars($computer['mac_address']); ?>" <?php echo ($editing || $viewing) ? 'disabled' : ''; ?>>
                <?php if ($editing || $viewing): ?>
                    <input type="hidden" name="mac" value="<?php echo hesk_htmlspecialchars($computer['mac_address']); ?>">
                <?php endif; ?>
            </div>
            <div class="form-group">
                <label for="os_name"><?php echo $hesklang['os_name']; ?>:</label>
                <input type="text" id="os_name" name="os_name" class="form-control" maxlength="100" value="<?php echo hesk_htmlspecialchars($computer['os_name']); ?>" <?php echo $viewing ? 'disabled' : ''; ?>>
            </div>
            <div class="form-group">
                <label for="os_version"><?php echo $hesklang['os_version']; ?>:</label>
                <input type="text" id="os_version" name="os_version" class="form-control" maxlength="50" value="<?php echo hesk_htmlspecialchars($computer['os_version']); ?>" <?php echo $viewing ? 'disabled' : ''; ?>>
            </div>
            </div>

            <!-- Row 3: Purchase / Warranty -->
            <div class="grid-2">
            <div class="form-group">
                <label for="purchase_date"><?php echo $hesklang['purchase_date']; ?>:</label>
                <input type="date" id="purchase_date" name="purchase_date" class="form-control" value="<?php echo hesk_htmlspecialchars($computer['purchase_date']); ?>" <?php echo (($editing && $computer['purchase_date']) || $viewing) ? 'disabled' : ''; ?>>
            </div>
            <div class="form-group">
                <label for="warranty_until"><?php echo $hesklang['warranty_until']; ?>:</label>
                <input type="date" id="warranty_until" name="warranty_until" class="form-control" value="<?php echo hesk_htmlspecialchars($computer['warranty_until']); ?>" <?php echo (($editing && $computer['warranty_until']) || $viewing) ? 'disabled' : ''; ?>>
            </div>
            </div>

            <!-- Row 4: Customer / Department -->
            <div class="grid-2">
                <div class="form-group">
                    <label for="customer_id"><?php echo $hesklang['customer']; ?>:</label>
                    <select name="customer_id" id="customer_id" class="form-control" <?php echo $viewing ? 'disabled' : ''; ?>>
                        <option value="0"><?php echo $hesklang['none']; ?></option>
                        <?php while ($u = hesk_dbFetchAssoc($customers)): ?>
                        <option value="<?php echo $u['id']; ?>" <?php if ($u['id'] == $computer['customer_id']) echo 'selected'; ?>>
                            <?php echo hesk_htmlspecialchars($u['name']); ?>
                        </option>
                        <?php endwhile; ?>
                    </select>
                </div>
                <div class="form-group">
                    <label for="department_id"><?php echo $hesklang['department']; ?>:</label>
                    <select name="department_id" id="department_id" class="form-control" <?php echo $viewing ? 'disabled' : ''; ?>>
                        <option value="0"><?php echo $hesklang['none']; ?></option>
                        <?php while ($s = hesk_dbFetchAssoc($departments)): ?>
                        <option value="<?php echo $s['id']; ?>" <?php if ($s['id'] == $computer['department_id']) echo 'selected'; ?>>
                            <?php echo hesk_htmlspecialchars($s['name']); ?>
                        </option>
                        <?php endwhile; ?>
                    </select>
                </div>
            </div>

            <!-- Row 5: CPU / MB -->
            <div class="grid-3">
                <!-- CPU -->
                <div class="form-group">
                    <label for="cpu_select"><?php echo $hesklang['cpu']; ?>: <span class="important">*</span></label>
                    <select name="cpu_id" id="cpu_select" class="form-control" <?php echo ($editing || $viewing) ? 'disabled' : ''; ?>>
                        <option value="0"><?php echo $hesklang['select_cpu']; ?></option>
                        <?php while ($c = hesk_dbFetchAssoc($cpus)): ?>
                        <option value="<?php echo $c['id']; ?>" <?php if ($c['id'] == $computer['cpu_id']) echo 'selected'; ?>>
                            <?php echo hesk_htmlspecialchars($c['model']); ?>
                        </option>
                        <?php endwhile; ?>
                    </select>
                    <?php if ($editing || $viewing): ?>
                        <input type="hidden" name="cpu_id" value="<?php echo $computer['cpu_id']; ?>">
                    <?php endif; ?>
                </div>
                <!-- Motherboard -->
                <div class="form-group">
                    <label for="mb_select"><?php echo $hesklang['motherboard']; ?>: <span class="important">*</span></label>
                    <select name="mb_id" id="mb_select" class="form-control" <?php echo ($editing || $viewing) ? 'disabled' : ''; ?>>
                        <option value="0"><?php echo $hesklang['select_mb']; ?></option>
                        <?php while ($m = hesk_dbFetchAssoc($mbs)): ?>
                        <option value="<?php echo $m['id']; ?>" <?php if ($m['id'] == $computer['mb_id']) echo 'selected'; ?>>
                            <?php echo hesk_htmlspecialchars($m['model']); ?>
                        </option>
                        <?php endwhile; ?>
                    </select>
                    <?php if ($editing || $viewing): ?>
                        <input type="hidden" name="mb_id" value="<?php echo $computer['mb_id']; ?>">
                    <?php endif; ?>
                </div>
                <!-- PSU -->
                <div class="form-group">
                    <label for="ps_select"><?php echo $hesklang['psu']; ?>:</label>
                    <select name="ps_id" id="ps_select" class="form-control" <?php echo $viewing ? 'disabled' : ''; ?>>
                        <option value="0"><?php echo $hesklang['none']; ?></option>
                        <?php while ($p = hesk_dbFetchAssoc($pss)): ?>
                        <option value="<?php echo $p['id']; ?>" <?php if ($p['id'] == $computer['ps_id']) echo 'selected'; ?>>
                            <?php echo hesk_htmlspecialchars($p['model'] . ' ' . $p['wattage_w'] . 'W'); ?>
                        </option>
                        <?php endwhile; ?>
                    </select>
                </div>
            </div>


            <div class="grid-2">
            <!-- RAM -->
            <div class="form-group" id="ram_container">
                <label><?php echo $hesklang['rams']; ?>:<span class="important">*</span></label>
                <div class="checkbox-group multi-container">
                    <p>Selecione placa‑mãe primeiro</p>
                </div>
            </div>

            <!-- Disks -->
            <div class="form-group" id="disk_container">
                <label><?php echo $hesklang['disks']; ?>:</label>
                <div class="checkbox-group multi-container">
                    <p>Selecione placa‑mãe primeiro</p>
                </div>
            </div>
            </div>

            <!-- flags -->
            <div class="form-group grid-4">
                <div><label><input type="checkbox" name="is_internal" value="1" <?php echo $computer['is_internal'] ? 'checked' : ''; ?> <?php echo $viewing ? 'disabled' : ''; ?>> <?php echo $hesklang['internal']; ?></label></div>
                <div><label><input type="checkbox" name="is_desktop" value="1" <?php echo $computer['is_desktop'] ? 'checked' : ''; ?> <?php echo $viewing ? 'disabled' : ''; ?>> <?php echo $hesklang['desktop']; ?></label></div>
                <div><label><input type="checkbox" name="is_secure" value="1" <?php echo $computer['is_secure'] ? 'checked' : ''; ?> <?php echo $viewing ? 'disabled' : ''; ?>> <?php echo $hesklang['protected']; ?></label></div>
                <?php if (!$viewing): ?>
                <button type="submit" class="btn btn-full" ripple="ripple">
                <?php echo $editing ? $hesklang['save_computer'] : $hesklang['create_computer']; ?>
                </button>
                <?php endif; ?>
            </div>


            <?php if ($viewing): ?>
                <div class="grid-2">
                    <div class="form-group">
                        <label for="created_at"><?php echo $hesklang['created_at']; ?><?php $hesklang['created_at'] ?>:</label>
                        <input type="text" name="created_at" id="created_at" class="form-control" value="<?php echo date('H:i:s - d/m/Y', strtotime($computer['created_at'])); ?>" disabled>
                    </div>
                    <div class="form-group">
                        <label for="updated_at"><?php echo $hesklang['updated_at']; ?><?php $hesklang['updated_at'] ?>:</label>
                        <input type="text" name="updated_at" id="updated_at" class="form-control" value="<?php echo date('H:i:s - d/m/Y', strtotime($computer['updated_at'])); ?>" disabled>
                    </div>
                </div>
            <?php endif; ?>
        </form>
    </div>
</div>

<script>
$(function(){
  $('#ram_container .multi-container, #disk_container .multi-container')
    .html('<p>Selecione placa‑mãe primeiro</p>');
  $('#ram_container input, #disk_container input').prop('disabled', true);

  function fetchComponents(mbId) {
    $.ajax({
      url: 'manage_computer.php',
      method: 'POST',
      dataType: 'json',
      data: {
        fetch_components: '1',
        mb_id: mbId
      },
      success: function(res) {
        let $ramBox = $('#ram_container .multi-container').empty();
        res.ram.forEach(function(r){
          $ramBox.append(
            $('<label>').append(
              $('<input>', {
                type: 'checkbox',
                name: 'ram_ids[]',
                value: r.id
              })
            ).append(' '+r.model+' '+r.size_gb+'GB ('+r.speed_mhz+'MHz)')
          );
        });
        $('#ram_container input').prop('disabled', false);

        let $diskBox = $('#disk_container .multi-container').empty();
        res.disk.forEach(function(d){
          $diskBox.append(
            $('<label>').append(
              $('<input>', {
                type: 'checkbox',
                name: 'disk_ids[]',
                value: d.id
              })
            ).append(' '+d.model+' '+d.size_gb+'GB ['+d.type+']')
          );
        });
        $('#disk_container input').prop('disabled', false);
      }
    });
  }

  $('#mb_select').on('change', function(){
    let mb = $(this).val();
    if (mb > 0) {
      fetchComponents(mb);
    } else {
      $('#ram_container .multi-container, #disk_container .multi-container')
        .html('<p>Selecione placa‑mãe primeiro</p>');
      $('#ram_container input, #disk_container input').prop('disabled', true);
    }
  });

  let initMb = $('#mb_select').val();
  if (initMb > 0) {
    fetchComponents(initMb);
  }
});
</script>


<?php
function try_save_computer() {
    global $dbp, $hesklang;
    hesk_token_check('POST');
    $orig_id = intval(hesk_POST('original_id', 0));
    $editing = ($orig_id > 0);
    $data = [
        'asset_tag'      => hesk_input(hesk_POST('asset_tag')),
        'name'           => hesk_input(hesk_POST('name')),
        'mac'            => strtolower(trim(hesk_POST('mac'))),
        'os_name'        => hesk_input(hesk_POST('os_name')),
        'os_version'     => hesk_input(hesk_POST('os_version')),
        'purchase_date'  => hesk_POST('purchase_date'),
        'warranty_until' => hesk_POST('warranty_until'),
        'customer_id'    => intval(hesk_POST('customer_id',0)),
        'department_id'  => intval(hesk_POST('department_id',0)),
        'cpu_id'         => intval(hesk_POST('cpu_id',0)),
        'mb_id'          => intval(hesk_POST('mb_id',0)),
        'ps_id'          => intval(hesk_POST('ps_id',0)),
        'is_internal'    => isset($_POST['is_internal'])?1:0,
        'is_desktop'     => isset($_POST['is_desktop'])?1:0,
        'is_secure'      => isset($_POST['is_secure'])?1:0,
        'ram_ids'        => hesk_POST_array('ram_ids'),
        'disk_ids'       => hesk_POST_array('disk_ids'),
    ];

    // Required fields for creation
    if (!$editing && ($data['mac']=='' || $data['name']=='' || $data['cpu_id']==0 || $data['mb_id']==0 || count($data['ram_ids'])==0)) {
        $_SESSION['iserror'] = 1;
        hesk_process_messages($hesklang['fill_required'], 'NOREDIRECT');
    }

    // MAC uniqueness
    $dup = hesk_dbQuery("
        SELECT 1 FROM `{$dbp}computers`
        WHERE `mac_address` = '".hesk_dbEscape($data['mac'])."'
        ".($orig_id?" AND `id` <> {$orig_id}":'')."
        LIMIT 1
    ");
    if (hesk_dbNumRows($dup)) {
        $_SESSION['iserror'] = 1;
        hesk_process_messages($hesklang['mac_exists'], 'NOREDIRECT');
    }

    // rollback on error
    if (isset($_SESSION['iserror'])) {
        header('Location: manage_computer.php'.($orig_id?('?id='.$orig_id):''));
        exit;
    }
    
    // Build SET clause
    $cols = "
        `asset_tag`      = '".hesk_dbEscape($data['asset_tag'])."',
        `mac_address`    = '".hesk_dbEscape($data['mac'])."',
        `name`           = '".hesk_dbEscape($data['name'])."',
        `os_name`        = '".hesk_dbEscape($data['os_name'])."',
        `os_version`     = '".hesk_dbEscape($data['os_version'])."',
        `purchase_date`  = ".($data['purchase_date']? "'".hesk_dbEscape($data['purchase_date'])."'": 'NULL').",
        `warranty_until` = ".($data['warranty_until']? "'".hesk_dbEscape($data['warranty_until'])."'": 'NULL').",
        `customer_id`    = ".($data['customer_id']? $data['customer_id'] : 'NULL').",
        `department_id`  = ".($data['department_id']? $data['department_id'] : 'NULL').",
        `cpu_id`         = {$data['cpu_id']},
        `mb_id`          = {$data['mb_id']},
        `ps_id`          = ".($data['ps_id']? $data['ps_id'] : 'NULL').",
        `is_internal`    = {$data['is_internal']},
        `is_desktop`     = {$data['is_desktop']},
        `is_secure`      = {$data['is_secure']}
    ";

    if ($orig_id) {
        // Update
        hesk_dbQuery("UPDATE `{$dbp}computers` SET {$cols} WHERE `id` = {$orig_id}");
        $comp_id = $orig_id;
        $msg = sprintf($hesklang['computer_updated'], '<i>'.hesk_htmlspecialchars($data['name']).'</i>');
    } else {
        // Insert
        hesk_dbQuery("INSERT INTO `{$dbp}computers` SET {$cols}");
        // get new ID
        global $hesk_db_link;
        $comp_id = mysqli_insert_id($hesk_db_link);
        $msg = sprintf($hesklang['computer_added'], '<i>'.hesk_htmlspecialchars($data['name']).'</i>');
    }

    // Refresh N:N links: RAM
    hesk_dbQuery("DELETE FROM `{$dbp}computer_has_ram` WHERE `computer_id` = {$comp_id}");
    foreach ($data['ram_ids'] as $slot => $ram_id) {
        $ram_id = intval($ram_id);
        hesk_dbQuery("
            INSERT INTO `{$dbp}computer_has_ram`
            (computer_id, ram_id, slot_number)
            VALUES ({$comp_id}, {$ram_id}, ".($slot+1).")
        ");
    }

    // Refresh N:N links: Disk
    hesk_dbQuery("DELETE FROM `{$dbp}computer_has_disk` WHERE `computer_id` = {$comp_id}");
    foreach ($data['disk_ids'] as $bay => $disk_id) {
        $disk_id = intval($disk_id);
        hesk_dbQuery("
            INSERT INTO `{$dbp}computer_has_disk`
            (computer_id, disk_id, bay_number)
            VALUES ({$comp_id}, {$disk_id}, ".($bay+1).")
        ");
    }

    hesk_cleanSessionVars('iserror');
    hesk_process_messages($msg, 'manage_computers.php', 'SUCCESS');
    exit;
}

require_once(HESK_PATH . 'inc/footer.inc.php');