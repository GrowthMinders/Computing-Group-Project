<?php
include_once "connection.php";

$name = $_POST['name'];
$supply = $_POST['supply'];
$canteen = $_POST['canteen'];
$user = $_POST['email']; 

$sql1 = "DELETE FROM cart WHERE name = ? AND supply = ? AND canteen = ? AND email = ?";
$data1 = array($name, $supply, $canteen, $user);

$result1 = sqlsrv_query($conn, $sql1, $data1);

sqlsrv_close($conn);
?>

