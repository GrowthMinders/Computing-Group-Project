<?php
include_once("../connection.php");

$sql = "SELECT * FROM product WHERE canteen = 'Hostel' AND supply = 'Ocean'";
$result = sqlsrv_query($conn, $sql);

$products = [];

while ($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC)) {
    $products[] = $row;
}

http_response_code(200);
echo json_encode($products);
?>
