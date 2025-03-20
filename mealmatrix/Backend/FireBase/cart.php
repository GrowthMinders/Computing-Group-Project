<?php
include_once "connection.php";
 
$name = $_POST['name'];
$price = $_POST['price'];
$supply = $_POST['supply'];
$canteen = $_POST['canteen'];
$qty = $_POST['quantity'];
$user = $_POST['user'];


# Checking if product is there in the cart
$sql1 = "SELECT * FROM cart WHERE name = ? AND price = ? AND supply = ? AND canteen = ? AND email = ?";
$data1 = array($name,$price,$supply,$canteen,$user);

$result1 = sqlsrv_query($conn, $sql1, $data1);

if (sqlsrv_fetch_array($result1, SQLSRV_FETCH_ASSOC)) {
    
    $sql2 = "UPDATE cart SET qty = qty+$qty WHERE name = ? AND price = ? AND supply = ? AND canteen = ? AND email = ?";
    $data2 = array($qty,$name,$price,$supply,$canteen,$user);

    $result2 = sqlsrv_query($conn, $sql2, $data2);


} else {

    $sql2 = "INSERT INTO cart (name, email, supply, price, qty, canteen) VALUES (?,?,?,?,?,?)";
    $data2 = array($name,$user,$supply,$price,$qty,$canteen);

    $result2 = sqlsrv_query($conn, $sql2, $data2);

    if($result2){
        http_response_code(200);
    }
   
}

sqlsrv_close($conn);

?>
