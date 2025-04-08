<?php
  $server = "10.16.130.245";
  $database = array(
    "Database" => "MealMatrix",
    "Uid" => "silva",
    "PWD" => "2002"
  );
  
  $conn = sqlsrv_connect($server, $database);
 ?>
