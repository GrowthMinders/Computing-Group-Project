<?php
   include_once "../../connection.php";

   $name = $_POST['name'];

   $sql = "DELETE FROM canteen WHERE name = ?";
   $data = array($name);

   $result = sqlsrv_query($conn, $sql, $data);

   if($result){
      header("Location: ../listcanteen.php");
   }
?>