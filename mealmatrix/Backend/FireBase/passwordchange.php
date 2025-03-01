<?php

include_once "../connection.php";

  $pass = $_POST["pass"];
  $email = $_POST["email"];


  $hash = password_hash($pass, PASSWORD_BCRYPT);

  $sql3 = " UPDATE customer SET password = ? WHERE email = ?";
  $data3 = array($hash, $email);
  
  $result3 = sqlsrv_query($conn, $sql3, $data3);

  if ($result3) {
    http_response_code(200);
  }else{
    http_response_code(400);
  }

sqlsrv_close($conn);
?>