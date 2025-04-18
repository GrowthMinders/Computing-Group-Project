<?php
   include_once "../../connection.php";

   $id = $_POST['pid'];

   $sql = "DELETE FROM product WHERE pid = ?";
   $data = array($id);

   $result = sqlsrv_query($conn, $sql, $data);

   if($result){
      header("Location: ../listproduct.php");
   }
?>