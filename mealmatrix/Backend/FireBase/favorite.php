<?php
include_once "connection.php";
 
$name = $_POST['name'];
$supply = $_POST['supply'];
$canteen = $_POST['canteen'];
$user = $_POST['user'];


# Checking if product is there in favorites
$sql1 = "SELECT * FROM favorite WHERE name = ? AND supply = ? AND email = ? AND canteen = ? ";
$data1 = array($name,$supply,$user,$canteen);

$result1 = sqlsrv_query($conn, $sql1, $data1);

if (sqlsrv_fetch_array($result1, SQLSRV_FETCH_ASSOC)) {
    
  http_response_code(204);

} else {
    $sql2 = "INSERT INTO favorite (name, email, supply, canteen) VALUES (?,?,?,?)";
    $data2 = array($name,$user,$supply,$canteen);

    $result2 = sqlsrv_query($conn, $sql2, $data2);

    if($result2){
        http_response_code(200);
    }
   
}

sqlsrv_close($conn);

?>