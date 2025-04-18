<?php
include_once "connection.php";

$input = file_get_contents('php://input');
$data = json_decode($input, true);
$email = $_POST["email"];
$total = $_POST["total"];

$leyons = [];
$Ocean = [];
$Finagle = [];
$Ayush = [];
$So = [];
$Hela = [];

$leyonstotal = 0;
$oceantotal = 0;
$finagletotal = 0;
$ayushtotal = 0;
$sototal = 0;
$helatotal = 0;

foreach ($data['items'] as $item) {
    if ($item['supply'] == "Leyons") {
        $leyons[] = $item;
        $leyonstotal = $leyonstotal + ($item['qty'] * $item['price']);
    } else if($item['supply'] == "Ocean"){
        $Ocean[] = $item; 
        $oceantotal = $oceantotal + ($item['qty'] * $item['price']); 
    }else if($item['supply'] == "Finagle"){
        $Finagle[] = $item; 
        $finagletotal = $finagletotal + ($item['qty'] * $item['price']); 
    }else if($item['supply'] == "Ayush"){
        $Ayush[] = $item; 
        $ayushtotal = $ayushtotal + ($item['qty'] * $item['price']);
    }else if($item['supply'] == "So cafe"){
        $So[] = $item;
        $sototal = $sototal + ($item['qty'] * $item['price']);
    }else{
        $Hela[] = $item;
        $helatotal = $helatotal + ($item['qty'] * $item['price']);
    }
}

date_default_timezone_set('Asia/Colombo');
$today = date('d/m/Y');

date_default_timezone_set('Asia/Colombo');
$time = date('H:i');


if($leyonstotal != 0){
    $sql1 = "INSERT INTO invoice (date, total, supply, time) VALUES (?, ?, ?, ?)";
    $data1 = array($today, $leyonstotal, "Leyons", $time);
        
    $result1 = sqlsrv_query($conn, $sql1, $data1);
    if($result1){
       sqlsrv_free_stmt($result1);

    }
}
if($oceantotal != 0){
    $sql1 = "INSERT INTO invoice (date, total, supply, time) VALUES (?, ?, ?, ?)";
    $data1 = array($today, $oceantotal, "Ocean", $time);
        
    $result1 = sqlsrv_query($conn, $sql1, $data1);
    if($result1){
        sqlsrv_free_stmt($result1);
        
    }
}
if($finagletotal != 0){
    $sql1 = "INSERT INTO invoice (date, total, supply, time) VALUES (?, ?, ?, ?)";
    $data1 = array($today, $finagletotal, "Finagle", $time);
        
    $result1 = sqlsrv_query($conn, $sql1, $data1);
    if($result1){
        sqlsrv_free_stmt($result1);
        $sql2 = "SELECT MAX(iid) AS lastid FROM invoice";
        $result2 = sqlsrv_query($conn, $sql2);
        if($row2 = sqlsrv_fetch_array($result1, SQLSRV_FETCH_ASSOC)){
           $conid = $row2["iid"];

           $sql3 = "INSERT INTO orders (qty, email, supply, canteen, state, date, inno) VALUES (?, ?, ?, ?, ?, ?, ?)";
           $data3 = array($name, $total, $hash, $tel);//change
               
           $result3 = sqlsrv_query($conn, $sql3, $data3);

        }
        
    }
}
if($ayushtotal != 0){
    $sql1 = "INSERT INTO invoice (date, total, supply, time) VALUES (?, ?, ?, ?)";
    $data1 = array($today, $ayushtotal, "Ayush", $time);
        
    $result1 = sqlsrv_query($conn, $sql1, $data1);
    if($result1){
        sqlsrv_free_stmt($result1);
        
    }
}
if($sototal != 0){
    $sql1 = "INSERT INTO invoice (date, total, supply, time) VALUES (?, ?, ?, ?)";
    $data1 = array($today, $sototal, "So Cafe", $time);
        
    $result1 = sqlsrv_query($conn, $sql1, $data1);
    if($result1){
        sqlsrv_free_stmt($result1);
        
    }
}
if($helatotal != 0){
    $sql1 = "INSERT INTO invoice (date, total, supply, time) VALUES (?, ?, ?, ?)";
    $data1 = array($today, $helatotal, "Hela Bojun", $time);
        
    $result1 = sqlsrv_query($conn, $sql1, $data1);
    if($result1){
        sqlsrv_free_stmt($result1);
        
    }
}



//sample block

    $sql3 = "INSERT INTO customer (date, total, supply, time) VALUES (?, ?, ?, ?)";
    $data3 = array($name, $total, $hash, $tel);
        
    $result3 = sqlsrv_query($conn, $sql3, $data3);


    


    

?>