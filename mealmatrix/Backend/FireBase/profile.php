<?php
include_once "connection.php";

$email = $_POST['email'];


$sql = "SELECT name, email, contact password FROM customer WHERE email = ?";
$data = array($email);

$result = sqlsrv_query($conn, $sql, $data);
$details = [];


while($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC)) {
    $details[] = $row;
    
} 

echo json_encode($details);
http_response_code(200);

?>