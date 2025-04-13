<?php
session_start();
include_once "../../connection.php";

$email = $_POST['email'];
$pass = $_POST['pass'];


$sql = "SELECT email, password, mac FROM customer WHERE email = ?";
$data = array($email);

$result = sqlsrv_query($conn, $sql, $data);

$row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC);

if ($row && $row["email"] == "MealMatrixCGP@outlook.com") {
    $dbpass = $row['password'];
    $dbmac = $row['mac'];

    $mac = shell_exec("python MAC_Address.py");  
    $mac = trim($mac);

    if(password_verify($mac, $dbmac)) {

        if(password_verify($pass, $dbpass)) {
            $_SESSION['admin'] = $email;
            header("Location: ../dashboard.php");
        } else {
            $_SESSION['error'] = "Invalid credentials";
            header("Location: ../login.php"); 
        }

    }else{
       header("Location: 404.php");
    }

} else {
    $_SESSION['error'] = "Account not found";
    header("Location: ../login.php");
}
?>