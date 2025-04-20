<?php
include_once "connection.php";

$products = urldecode($_GET['pid']);
$email = urldecode($_GET['email']); 
$price = urldecode($_GET['price']);
$qty = urldecode($_GET['qty']);
$conid = "";
$pname = "";
$psupply = "";
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
       $qtyArray = json_decode($qty, true); 
       
       for($i = 0; $i < count($productsArray); $i++){
           $currentid = $productsArray[$i];

           //retrieveing product data using the id
           $sql2 = "SELECT name, supply, canteen FROM product WHERE pid = ?";
           $data2 = array($currentid);
        
           $result2 = sqlsrv_query($conn, $sql2, $data2);
           while($row2 = sqlsrv_fetch_array($result2, SQLSRV_FETCH_ASSOC)){
               $pname = $row2["name"];
               $psupply = $row2["supply"];
               $pcanteen = $row2["canteen"];
           }

           //Quatity getting
           $currentqty = $qtyArray[$i];

           //Inserting data to orders table
           $sql3 = "INSERT INTO orders (stime, date, qty, email, name, supply, canteen, state, iino) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
           $data3 = array($time, $today, $currentqty, $email, $pname, $psupply, $pcanteen, "Not Done", $conid);

           $result3 = sqlsrv_query($conn, $sql3, $data3);
       }

       
       $sql4 = "DELETE FROM cart WHERE email = ?";
       $data4 = array($email);
       $result4 = sqlsrv_query($conn, $sql4, $data4);

       if($result4){
           header("Location: http://192.168.177.67/FireBase/invoicemailer.php?email=$email&iid=$conid");
           exit();
       }
    }
}
?>