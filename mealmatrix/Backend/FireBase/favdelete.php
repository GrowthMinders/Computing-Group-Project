<?php
   include_once "connection.php";

   $name= $_POST['name'];
   $supply = $_POST['supply'];
   $canteen = $_POST['canteen'];
   $email = $_POST['email'];

   $sql = "DELETE FROM favorite WHERE email = ? AND name = ? AND supply = ? AND canteen = ?";
   $data = array($email, $name, $supply, $canteen);

   $result = sqlsrv_query($conn, $sql, $data);

   if($result){
      http_response_code(200);
   }
?>