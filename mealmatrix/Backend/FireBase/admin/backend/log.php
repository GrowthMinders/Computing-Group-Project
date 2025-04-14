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

        $mac = shell_exec('getmac /FO CSV /NH 2>&1');
        if ($mac) {
          $mac = explode(',', $mac)[0] ?? '';
          $mac = trim($mac, ' "');
          $mac = preg_replace('/[^0-9A-Fa-f]/', '', $mac);
                    
          if (strlen($mac) === 12) {
            $mac = implode(':', str_split($mac, 2));
            $mac = strtoupper($mac);
          }
        }    

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