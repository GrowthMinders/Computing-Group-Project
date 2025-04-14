<?php

include_once "../../connection.php";
 
// Canteen table
$cname = $_POST['cname'];
$open = $_POST['otime'];
$close = $_POST['ctime'];
$location = $_POST['location'];
$contact = $_POST['contact'];

//Customer table
$name = $_POST['name'];
$contact = $_POST['contact'];
$email = $_POST['email'];
$pass = $_POST['pass']; 
$mac = $_POST['mac'];

$sql3 = "INSERT INTO canteen (name, otime, ctime, location, contact) VALUES (?, ?, ?, ?, ?)";
$data3 = array($cname, $open, $close, $location, $contact);
        
$result3 = sqlsrv_query($conn, $sql3, $data3);

  if($result3 == true){

    if($_FILES['image'] != ""){
        $image = $_FILES['image']['tmp_name'];
        $imagecontent = file_get_contents($image);
    
        $hash = password_hash($pass, PASSWORD_BCRYPT);
        $sql2 = "INSERT INTO customer (name, email, password, image, contact, mac) VALUES (?, ?, ?, ?, ?, ?)";
        $data2 = array($name, $email, $hash, $imagecontent, $contact, $mac);
        
        $result2 = sqlsrv_query($conn, $sql2, $data2);

        if($result2 == true){
            header("Location: ../dashboard.php");
        }else{
            die(print_r(sqlsrv_errors(), true));   
        }

    }else{
        $hash = password_hash($pass, PASSWORD_BCRYPT);
        $sql = "INSERT INTO customer (name, email, password, contact, mac) VALUES (?, ?, ?, ?, ?)";
        $data = array($name, $email, $hash, $contact, $mac);
    
        $result = sqlsrv_query($conn, $sql, $data);

        if($result == true){
           header("Location: ../dashboard.php");
        }else{
           echo("Canteen Owner was not added");   
        }
    }

}else{
    echo("Canteen was not added");   
}

sqlsrv_close($conn);
?>
