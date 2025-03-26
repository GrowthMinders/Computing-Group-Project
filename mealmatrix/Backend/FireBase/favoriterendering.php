<?php
include_once "connection.php";

$email = $_POST['email'];


$sql = "SELECT * FROM favorite WHERE email = ?";
$data = array($email);

$result = sqlsrv_query($conn, $sql, $data);
$favorites = [];



while($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC)) {
    $favorites[] = $row; 
} 

$favorites["name"];

echo json_encode($favorites);
http_response_code(200);
?>