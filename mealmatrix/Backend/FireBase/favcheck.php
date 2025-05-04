<?php
include_once "connection.php";

$email = $_POST['user'];
$pname = $_POST['name']; 
$supply = $_POST['supply']; 
$canteen = $_POST['canteen']; 

$sql = "SELECT name FROM favorite WHERE email = ? AND name = ? AND supply = ? AND canteen = ?";
$data = array($email, $pname, $supply, $canteen);

$result = sqlsrv_query($conn, $sql, $data);

if($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC)) {
    http_response_code(200);
} else {
    http_response_code(204);
}
?>
