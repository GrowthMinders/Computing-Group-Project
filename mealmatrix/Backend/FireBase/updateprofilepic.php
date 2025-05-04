<?php
include_once "connection.php";

$email = $_POST['email'];

$image = $_FILES['image']['tmp_name'];
$imagecontent = file_get_contents($image);  

$sql3 = " UPDATE customer SET image = ? WHERE email = ? ";
$data3 = array($imagecontent, $email);

$result3 = sqlsrv_query($conn, $sql3, $data3);

if($result3){
    http_response_code(200);
}else{
    http_response_code(204);
}

?>