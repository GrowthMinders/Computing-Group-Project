<?php
include_once "connection.php";
 
$name = $_POST['name'];
$supply = $_POST['supply'];
$canteen = $_POST['canteen'];
$user = $_POST['email'];
$stime = $_POST['stime'];

    $sql2 = "UPDATE orders SET state = 'Done' WHERE name = ? AND supply = ? AND canteen = ? AND email = ? AND stime = ?";
    $data2 = array($name, $supply, $canteen, $user, $stime);

    $result2 = sqlsrv_query($conn, $sql2, $data2);

    if($result2){
        http_response_code(200);
    }

sqlsrv_close($conn);

?>