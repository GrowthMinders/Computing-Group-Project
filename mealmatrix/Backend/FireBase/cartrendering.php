<?php
include_once "connection.php";

$email = $_POST['email'];


$sql = "SELECT * FROM cart WHERE email = ?";
$data = array($email);

$result = sqlsrv_query($conn, $sql, $data);
$products = [];



while($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC)) {

    $products[] = $row; 
} 

echo json_encode($products);
http_response_code(200);
?>