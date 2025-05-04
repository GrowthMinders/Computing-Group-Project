<?php
include_once "connection.php";

$products = urldecode($_GET['names']);
$supply = urldecode($_GET['supply']);
$email = urldecode($_GET['email']); 
$price = urldecode($_GET['price']);
$qty = urldecode($_GET['qty']);
$conid = "";
$pcanteen = "";

date_default_timezone_set('Asia/Colombo');
$today = date('d/m/Y');
$time = date('H:i');

//Invoice Created
$sql = "INSERT INTO invoice (date, total, time) VALUES (?, ?, ?)";
$data = array($today, $price, $time);
        
$result = sqlsrv_query($conn, $sql, $data);
if($result){
    // Getting the invoice number
    $sql1 = "SELECT MAX(iid) AS lastid FROM invoice";
    $result1 = sqlsrv_query($conn, $sql1);
    if($row1 = sqlsrv_fetch_array($result1, SQLSRV_FETCH_ASSOC)) {
       $conid = $row1["lastid"];

       //Creating the order table entries
       $productsArray = json_decode($products, true);
       $supplyArray = json_decode($supply, true);
       $qtyArray = json_decode($qty, true); 
       
       for($i = 0; $i < count($productsArray); $i++){
           $currentname = $productsArray[$i];
           $currentsupply = $supplyArray[$i];

           //Quatity getting
           $currentqty = $qtyArray[$i];

           if($currentsupply == "Ayush"){
              $pcanteen = "Edge";
           }else if($currentsupply == "So Cafe"){
              $pcanteen = "Edge";
           }else if($currentsupply == "Leyons"){
              $pcanteen = "Audi";
           }else if($currentsupply == "Ocean"){
              $pcanteen = "Hostel";
           }else if($currentsupply == "Finagle"){
              $pcanteen = "Finagle";
           }else if($currentsupply == "Hela Bojun"){
              $pcanteen = "Edge";
           }

           //Inserting data to orders table
           $sql3 = "INSERT INTO orders (stime, date, qty, email, name, supply, canteen, state, iino) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
           $data3 = array($time, $today, $currentqty, $email, $currentname, $currentsupply, $pcanteen, "Not Done", $conid);

           $result3 = sqlsrv_query($conn, $sql3, $data3);
       }

       $sql4 = "DELETE FROM cart WHERE email = ?";
       $data4 = array($email);
       $result4 = sqlsrv_query($conn, $sql4, $data4);
       if($result4){
          header("Location: http://192.168.8.101/FireBase/invoicemailer.php?email=$email&iid=$conid");
          exit();
       }
    }
}
?>
