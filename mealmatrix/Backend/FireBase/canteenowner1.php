<?php
include_once "connection.php";

$supply = $_POST['supply'];
$canteen = $_POST['canteen'];

date_default_timezone_set('Asia/Colombo');
$today = date('d/m/Y');


$sql = "SELECT name, qty, stime, email FROM orders WHERE supply = ? AND state = ? AND canteen = ? AND date = ?";
$data = array($supply, "Not Done", $canteen, $today);

$result = sqlsrv_query($conn, $sql, $data);
$prepare = [];



while($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC)) {
    if($row["name"]){

        $pname = $row["name"];

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