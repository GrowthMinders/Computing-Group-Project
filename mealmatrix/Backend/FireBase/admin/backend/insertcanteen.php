<?php

include_once "../../connection.php";
 
$cname = $_POST['cname'];// Canteen table
$open = $_POST['otime'];
$close = $_POST['ctime'];
$location = $_POST['location'];
$contact = $_POST['contact'];

$sql3 = "INSERT INTO canteen (name, otime, ctime, location, contact) VALUES (?, ?, ?, ?, ?)";
$data3 = array($cname, $open, $close, $location, $contact);
        
$result3 = sqlsrv_query($conn, $sql3, $data3);

if($result3 == true){
    header("Location: ../dashboard.php");
}else{
    echo("Canteen was not added");   
}
sqlsrv_close($conn);
?>
