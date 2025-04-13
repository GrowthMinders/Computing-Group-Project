<?php
   include_once "../../connection.php";

   $email = $_POST['email'];

   $sql = "DELETE FROM customer WHERE email = ?";
   $data = array($email);

   $result = sqlsrv_query($conn, $sql, $data);

   if($result){
      header("Location: ../listsupplier.php");
   }
?>