<?php
include_once "connection.php";

$email = $_POST['email'];


$sql = "SELECT * FROM cart WHERE email = ?";
$data = array($email);

$result = sqlsrv_query($conn, $sql, $data);
$products = [];



while($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC)) {
    if($row["name"]){
        
        $pcname = $row["name"];
        $sql1 = "SELECT image FROM product WHERE name = ?";
        $data1 = array($pcname);

        $result1 = sqlsrv_query($conn, $sql1, $data1);

        while($row1 = sqlsrv_fetch_array($result1, SQLSRV_FETCH_ASSOC)) {
            $row["image"] = $row1["image"];
        }

        $products[] = $row; 
    }
    
} 

echo json_encode($products);
http_response_code(200);
?>