<?php
  $server = " 192.168.195.67";
  $database = array(
    "Database" => "MealMatrix",
    "Uid" => "silva",
    "PWD" => "2002"
  );
  
  $conn = sqlsrv_connect($server, $database);
 ?>
