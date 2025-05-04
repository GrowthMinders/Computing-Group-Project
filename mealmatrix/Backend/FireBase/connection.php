<?php
  $server = "192.168.8.101";
  $database = array(
    "Database" => "MealMatrix",
    "Uid" => "silva",
    "PWD" => "2002"
  );
  
  $conn = sqlsrv_connect($server, $database);
 ?>
