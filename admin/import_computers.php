<?php
define('IN_SCRIPT', 1);
define('HESK_PATH', '../');
define('IS_ASSET', 1);

require(HESK_PATH . 'hesk_settings.inc.php');
require(HESK_PATH . 'inc/common.inc.php');
require(HESK_PATH . 'inc/admin_functions.inc.php');
hesk_load_database_functions();
hesk_session_start();
hesk_dbConnect();
hesk_isLoggedIn();
hesk_checkPermission('can_man_assets');

if (empty($_FILES['computers_file'])) {
    hesk_process_messages($hesklang['no_json'], 'manage_computers.php', 'ERROR');
    exit;
}

$overwrite = !empty($_POST['overwrite']);
$tmp = $_FILES['computers_file']['tmp_name'];
$json = file_get_contents($tmp);
$data = json_decode($json, true);
if (json_last_error() !== JSON_ERROR_NONE) {
    hesk_process_messages($hesklang['invalid_json'], 'manage_computers.php', 'ERROR');
    exit;
}

$dbp = hesk_dbEscape($hesk_settings['db_pfix']);
global $hesk_db_link;

$imported = $skipped = 0;

foreach ($data as $comp) {
    $comp_id = null;
    // Basic fields
    $name       = hesk_dbEscape($comp['PC']);
    $mac        = hesk_dbEscape($comp['MAC']);
    $is_desktop = (strtolower($comp['TYPE']) === 'desktop') ? 1 : 0;
    $os_name    = hesk_dbEscape($comp['SO']);
    $os_version = '';

    // Check for existing by MAC
    $res = hesk_dbQuery("SELECT id FROM {$dbp}computers WHERE mac_address = '$mac'");
    if (hesk_dbNumRows($res)) {
        $row = hesk_dbFetchAssoc($res);
        if (!$overwrite) { $skipped++; continue; }
        $comp_id = $row['id'];
        hesk_dbQuery("DELETE FROM {$dbp}computer_has_ram  WHERE computer_id = $comp_id");
        hesk_dbQuery("DELETE FROM {$dbp}computer_has_disk WHERE computer_id = $comp_id");
    }

    // CPU
    $cpu_model = hesk_dbEscape($comp['CPU']);
    $cores     = (int)$comp['CORES'];
    $threads   = (int)$comp['THREADS'];
    $gpu       = hesk_dbEscape($comp['GPU']);
    $res = hesk_dbQuery("SELECT id FROM {$dbp}computers_cpu WHERE model = '$cpu_model'");
    if (hesk_dbNumRows($res)) {
        $cpu_id = hesk_dbFetchAssoc($res)['id'];
    } else {
        hesk_dbQuery("INSERT INTO {$dbp}computers_cpu (model, cores, threads, gpu, stock, is_active)
                      VALUES ('$cpu_model',$cores,$threads,'$gpu',0,1)");
        $cpu_id = mysqli_insert_id($hesk_db_link);
    }

    // Motherboard
    $mb_model  = hesk_dbEscape($comp['MOTHERBOARD']);
    $ram_slots = (int)$comp['RAM_SLOTS'];
    $max_ram   = (int)$comp['MAX_RAM'];
    $chipset   = hesk_dbEscape($comp['CHIPSET']);
    $ddr       = !empty($comp['RAM']) ? hesk_dbEscape($comp['RAM'][0]['Type']) : '';
    $ifaces    = array_unique(array_column($comp['DISKS'],'Interface'));
    $st_ifaces = hesk_dbEscape(implode(',',$ifaces));
    $res = hesk_dbQuery("SELECT id FROM {$dbp}computers_mb WHERE model = '$mb_model'");
    if (hesk_dbNumRows($res)) {
        $mb_id = hesk_dbFetchAssoc($res)['id'];
    } else {
        hesk_dbQuery("INSERT INTO {$dbp}computers_mb
            (model, ram_slots, ddr, max_ram_gb, network_iface, storage_ifaces, chipset, stock, is_active)
         VALUES
            ('$mb_model',$ram_slots,'$ddr',$max_ram,'cable','$st_ifaces','$chipset',0,1)");
        $mb_id = mysqli_insert_id($hesk_db_link);
    }

    // Computer row
    $ps_id = 'NULL';
    if (empty($comp_id)) {
        hesk_dbQuery("INSERT INTO {$dbp}computers
            (name, mac_address, cpu_id, mb_id, ps_id, os_name, os_version,
             is_internal, is_desktop, is_secure, is_active)
         VALUES
            ('$name','$mac',$cpu_id,$mb_id,$ps_id,'$os_name','$os_version',1,$is_desktop,1,1)");
        $comp_id = mysqli_insert_id($hesk_db_link);
    } else {
        hesk_dbQuery("UPDATE {$dbp}computers
            SET name='$name', cpu_id=$cpu_id, mb_id=$mb_id, os_name='$os_name'
            WHERE id = $comp_id");
    }

    // RAM modules
    $ram = !empty($comp['RAM']) && is_array($comp['RAM']) ? $comp['RAM'] : [];
    foreach ($comp['RAM'] as $i => $r) {
        $r_model = hesk_dbEscape($r['Model']);
        $r_size  = (int)$r['SizeGB'];
        $r_speed = (int)$r['Speed'];
        $r_type  = hesk_dbEscape($r['Type']);
        $res = hesk_dbQuery("SELECT id FROM {$dbp}computers_ram WHERE model='$r_model'");
        if (hesk_dbNumRows($res)) {
            $ram_id = hesk_dbFetchAssoc($res)['id'];
        } else {
            hesk_dbQuery("INSERT INTO {$dbp}computers_ram
                (model, size_gb, speed_mhz, ram_type, stock, is_active)
             VALUES
                ('$r_model',$r_size,$r_speed,'$r_type',0,1)");
            $ram_id = mysqli_insert_id($hesk_db_link);
        }
        $slot = $i + 1;
        hesk_dbQuery("INSERT INTO {$dbp}computer_has_ram
            (computer_id, ram_id, slot_number)
         VALUES
            ($comp_id,$ram_id,$slot)");
    }

    // Disks
    $disks = !empty($comp['DISKS']) && is_array($comp['DISKS']) ? $comp['DISKS'] : [];
    foreach ($comp['DISKS'] as $i => $d) {
        $d_model = hesk_dbEscape($d['Model']);
        $d_intf  = hesk_dbEscape($d['Interface']);
        $d_size  = (int)round($d['SizeGB']);
        $d_type  = strtoupper($d['Tipo'])==='HDD' ? 'HDD' : 'SSD';
        $res = hesk_dbQuery("SELECT id FROM {$dbp}computers_disk WHERE model='$d_model'");
        if (hesk_dbNumRows($res)) {
            $disk_id = hesk_dbFetchAssoc($res)['id'];
        } else {
            hesk_dbQuery("INSERT INTO {$dbp}computers_disk
                (model, type, interface, size_gb, stock, is_active)
             VALUES
                ('$d_model','$d_type','$d_intf',$d_size,0,1)");
            $disk_id = mysqli_insert_id($hesk_db_link);
        }
        $bay = $i + 1;
        try {
            hesk_dbQuery("INSERT INTO {$dbp}computer_has_disk
                (computer_id, disk_id, bay_number)
             VALUES
                ($comp_id,$disk_id,$bay)");
        } catch (Exception $e) {
            hesk_process_messages("Error in disk insertion for computer {$name}: " . $e->getMessage(), 'manage_computers.php', 'ERROR');
        }
    }

    $imported++;
}
$msg = sprintf($hesklang['import_success'], '<i>' . hesk_htmlspecialchars($imported) . '</i>', '<i>'.hesk_htmlspecialchars($skipped).'</i>');
hesk_process_messages($msg, 'manage_computers.php', 'SUCCESS');
exit;
