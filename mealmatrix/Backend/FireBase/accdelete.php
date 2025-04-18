<?php
   include_once "connection.php";

   $email= $_POST['email'];
   $password = $_POST['pass'];

   $sql = "SELECT password FROM customer WHERE email = ?";
   $data = array($email);

   $result = sqlsrv_query($conn, $sql, $data);

   if($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC)){
      $dbpass = $row["password"];

      if (password_verify($password, $dbpass)) {
        $sql1 = "DELETE FROM customer WHERE email = ?";
        $data1 = array($email);
  
        $result1 = sqlsrv_query($conn, $sql1, $data1);
        if($result1){
          http_response_code(200);
        } 
      }
   }else{
      http_response_code(204);
   }
?>