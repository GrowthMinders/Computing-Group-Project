<?php
  $server = "192.168.72.67";
  $database = array(
    "Database" => "MealMatrix",
    "Uid" => "Supun",
    "PWD" => "2002"
  );
  
  $conn = sqlsrv_connect($server, $database);
 ?>
