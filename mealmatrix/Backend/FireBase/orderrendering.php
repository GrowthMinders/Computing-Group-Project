<?php
include_once "connection.php";

$email = $_POST['email'];


$sql = "SELECT * FROM orders WHERE email = ? AND state = ?";
$data = array($email, "Not Done");

$result = sqlsrv_query($conn, $sql, $data);
$prepare = [];



while($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC)) {
    if($row["name"] && $row["supply"] && $row["canteen"]){

        $pname = $row["name"];
        $supply = $row["supply"];
        $canteen = $row["canteen"];

        $sql1 = "SELECT image, price FROM product WHERE name = ? AND supply = ? AND canteen = ?";
        $data1 = array($pname, $supply, $canteen);

        $result1 = sqlsrv_query($conn, $sql1, $data1);

        while($row1 = sqlsrv_fetch_array($result1, SQLSRV_FETCH_ASSOC)) {
            $row["image"] = $row1["image"];
            $row["price"] = $row1["price"];
        }
        
        $prepare[] = $row;
    }
    
} 

echo json_encode($prepare);
http_response_code(200);
?>