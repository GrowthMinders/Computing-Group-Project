<?php
include_once "connection.php";

$email = $_POST['email'];

$sql = "SELECT name, email, contact, password, image FROM customer WHERE email = ?";
$data = array($email);

$result = sqlsrv_query($conn, $sql, $data);

if ($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC)) {
    if (!empty($row['image'])) {
        $row['image'] = base64_encode($row['image']);
    }
    echo json_encode($row); 
    http_response_code(200);
}
?>