<?php
include_once "connection.php";

$email = $_POST['email'];
$pass = $_POST['pass'];


$sql = "SELECT email, password FROM customer WHERE email = ?";
$data = array($email);

$result = sqlsrv_query($conn, $sql, $data);

$row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC);

if ($row) {
    $dbpass = $row['password'];

    if (password_verify($pass, $dbpass)) {
        http_response_code(200);
    } else {
        http_response_code(203);
    }
} else {
    http_response_code(204);
}
?>