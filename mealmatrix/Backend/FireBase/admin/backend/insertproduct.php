<?php

include_once "../../connection.php";
 
$name = $_POST['name'];
$category = $_POST['category'];
$price = $_POST['price'];
$image = $_POST['image'];
$supply = $_POST['supply'];
$canteen = $_POST['canteen'];


$sql3 = "INSERT INTO product (name, category, price, image, supply, canteen) VALUES (?, ?, ?, ?, ?, ?)";
$data3 = array($name, $category, $price, $image, $supply, $canteen);
        
$result3 = sqlsrv_query($conn, $sql3, $data3);

if($result3 == true){
    header("Location: ../dashboard.php");
}else{
    echo("Product was not added");
}

sqlsrv_close($conn);

?>
