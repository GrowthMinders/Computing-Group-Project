<?php
include_once "connection.php";
$user = $_POST['email']; 

$sql1 = "DELETE FROM cart WHERE email = ?";
$data1 = array($user);

$result1 = sqlsrv_query($conn, $sql1, $data1);

if($result1 == true){
  http_response_code(200);
}else{
  http_response_code(400);
}

sqlsrv_close($conn);
?>