<?php

include_once "../connection.php";

  $pass = $_POST["pass"];
  $email = $_POST["email"];


  $hash = password_hash($pass, PASSWORD_BCRYPT);

  $sql3 = " UPDATE customer SET password = ? WHERE email = ?";
  $data3 = array($hash, $email);
  
  $result3 = sqlsrv_query($conn, $sql3, $data3);

  if ($result3) {
    header("Location: http://10.18.52.113/Firebase/web/passsuccess.php");
  }else{
    header("Location: http://10.18.52.113/Firebase/web/passunsuccess.php");
  }

sqlsrv_close($conn);
?>