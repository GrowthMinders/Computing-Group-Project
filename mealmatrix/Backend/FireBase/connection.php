<?php
  $server = "192.168.177.67";
  $database = array(
    "Database" => "MealMatrix",
    "Uid" => "silva",
    "PWD" => "2002"
  );
  
  $conn = sqlsrv_connect($server, $database);
 ?>
