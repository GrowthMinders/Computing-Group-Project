<?php

include_once "connection.php";
 
$name = $_POST['name'];
$email = $_POST['email'];
$tel = $_POST['phone'];
$pass = $_POST['pass'];
$imagecontent = null;

if($_FILES['image'] != ""){
    $image = $_FILES['image']['tmp_name'];
    $imagecontent = file_get_contents($image);
    //when no image selected
      # Checking contact number existence
      $sql1 = "SELECT contact FROM customer WHERE contact = ?";
      $data1 = array($tel);

      $result1 = sqlsrv_query($conn, $sql1, $data1);

      if (sqlsrv_fetch_array($result1, SQLSRV_FETCH_ASSOC)) {
          http_response_code(409);
          echo json_encode(array("status" => "error", "message" => "Contact number already registered"));
      } else {
          # Checking email existence
          $sql2 = "SELECT email FROM customer WHERE email = ?";
          $data2 = array($email);

          $result2 = sqlsrv_query($conn, $sql2, $data2);


          if (sqlsrv_fetch_array($result2, SQLSRV_FETCH_ASSOC)) {
              http_response_code(204);
              echo json_encode(array("status" => "error", "message" => "Email already registered"));
          } else {
             # Inserting data upon checking if contact number and email are not duplicated
             $hash = password_hash($pass, PASSWORD_BCRYPT);

             $sql3 = "INSERT INTO customer (name, email, password, contact, image) VALUES (?, ?, ?, ?, ?)";
             $data3 = array($name, $email, $hash, $tel, $imagecontent);
        
             $result3 = sqlsrv_query($conn, $sql3, $data3);
          }
      }
    //end of it
}else{
     # Checking contact number existence
     $sql1 = "SELECT contact FROM customer WHERE contact = ?";
     $data1 = array($tel);

     $result1 = sqlsrv_query($conn, $sql1, $data1);

     if (sqlsrv_fetch_array($result1, SQLSRV_FETCH_ASSOC)) {
         http_response_code(409);
         echo json_encode(array("status" => "error", "message" => "Contact number already registered"));
     } else {
         # Checking email existence
         $sql2 = "SELECT email FROM customer WHERE email = ?";
         $data2 = array($email);

         $result2 = sqlsrv_query($conn, $sql2, $data2);


       if (sqlsrv_fetch_array($result2, SQLSRV_FETCH_ASSOC)) {
           http_response_code(204);
           echo json_encode(array("status" => "error", "message" => "Email already registered"));
       } else {
           # Inserting data upon checking if contact number and email are not duplicated
           $hash = password_hash($pass, PASSWORD_BCRYPT);

           $sql3 = "INSERT INTO customer (name, email, password, contact) VALUES (?, ?, ?, ?)";
           $data3 = array($name, $email, $hash, $tel);
        
          $result3 = sqlsrv_query($conn, $sql3, $data3);
       }
     }
}



sqlsrv_close($conn);

?>
