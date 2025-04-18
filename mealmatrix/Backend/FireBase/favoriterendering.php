<?php
include_once "connection.php";

$email = $_POST['email'];


$sql = "SELECT * FROM favorite WHERE email = ?";
$data = array($email);

$result = sqlsrv_query($conn, $sql, $data);
$favorites = [];



while($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC)) {
    if($row["name"]){

        $pname = $row["name"];
        $sql1 = "SELECT image, price FROM product WHERE name = ?";
        $data1 = array($pname);

        $result1 = sqlsrv_query($conn, $sql1, $data1);

        while($row1 = sqlsrv_fetch_array($result1, SQLSRV_FETCH_ASSOC)) {
            $row["image"] = $row1["image"];
            $row["price"] = $row1["price"];
        }
        
        $favorites[] = $row; 
    }
    
} 

echo json_encode($favorites);
http_response_code(200);
?>