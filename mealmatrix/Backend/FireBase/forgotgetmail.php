<?php
include_once "connection.php"; // Include the database connection file

$email = $_POST['email'];

// Prepare the SQL query to check if the email exists in the database
$sql = "SELECT email FROM customer WHERE email = ?";
$data = array($email);

// Execute the query
$result = sqlsrv_query($conn, $sql, $data);

// Fetch the result as an associative array
$row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC);

// If the email exists in the database
if ($row) {
    // Initialize cURL session
    $ch = curl_init("http://192.168.177.67/Firebase/passwordresetmail.php");

    // Set cURL options
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_POSTFIELDS, "email=" . urlencode($email));
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

    // Execute the request and store response
    $response = curl_exec($ch);

    // Close cURL session
    curl_close($ch);

    // Output response (optional)
    echo $response;
    exit(); // Stop further execution
} else {

    http_response_code(401);
    echo json_encode(array("status" => "error", "message" => "Account not found"));
}
?>