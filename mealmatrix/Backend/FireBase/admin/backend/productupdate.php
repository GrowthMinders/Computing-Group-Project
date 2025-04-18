<?php
   include_once "../../connection.php";

   $name = $_POST['name'];
   $category = $_POST['category'];
   $price = $_POST['price'];
   $canteen = $_POST['canteen'];
   $supply = $_POST['supply'];
   $id = $_POST['pid'];

   $sql = "UPDATE product SET name = ?, category = ?, price = ?, canteen = ?, supply = ? WHERE pid = ?";
   $data = array($name, $category, $price, $canteen, $supply, $id);

   $result = sqlsrv_query($conn, $sql, $data);

   if($result){
      header("Location: ../listproduct.php");
   }
?>