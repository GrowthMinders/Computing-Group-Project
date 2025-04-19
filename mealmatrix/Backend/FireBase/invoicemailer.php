<?php
// Enable error reporting
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Include PHPMailer autoload
require 'C:/xampp/htdocs/FireBase/vendor/autoload.php';

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

// Get the email from the POST request
$email = urldecode($_GET['email']);
$invoiceno = urldecode($_GET['iid']);
$total = 0;

date_default_timezone_set('Asia/Colombo');
$today = date('d/m/Y');

date_default_timezone_set('Asia/Colombo');
$time = date('H:i');

// Check if the email is empty
if (empty($email)) {
    error_log('Email Empty'); // Log the error
    http_response_code(400); // Bad request
    log(2);
    exit(); // Stop further execution
}

// HTML content for the invoice
$invoiceHTML = <<<HTML
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meal Matrix</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap');
        
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f8f8;
            margin: 0;
            padding: 20px;
            color: #333;
        }
        
        .invoice-container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            overflow: hidden;
        }
        
        .invoice-header {
            background: linear-gradient(135deg, #ff9a9e 0%, #fad0c4 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }
        
        .restaurant-name {
            font-size: 32px;
            font-weight: 700;
            margin: 0;
            letter-spacing: 1px;
        }
        
        .invoice-title {
            font-size: 24px;
            margin: 10px 0 0;
            font-weight: 600;
        }
        
        .invoice-info {
            display: flex;
            justify-content: space-between;
            padding: 20px 30px;
            border-bottom: 1px solid #eee;
        }
        
        .info-section {
            flex: 1;
        }
        
        .info-label {
            font-weight: 600;
            color: #666;
            margin-bottom: 5px;
            font-size: 14px;
        }
        
        .info-value {
            font-size: 16px;
        }
        
        .items-table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .items-table th {
            background-color: #f5f5f5;
            padding: 15px;
            text-align: left;
            font-weight: 600;
            color: #555;
        }
        
        .items-table td {
            padding: 15px;
            border-bottom: 1px solid #eee;
        }
        
        .items-table tr:last-child td {
            border-bottom: none;
        }
        
        .text-right {
            text-align: right;
        }
        
        .total-section {
            padding: 20px 30px;
            background-color: #f9f9f9;
            border-top: 1px solid #eee;
        }
        
        .total-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }
        
        .total-label {
            font-weight: 600;
        }
        
        .grand-total {
            font-size: 20px;
            color: #ff6b6b;
            font-weight: 700;
        }
        
        .footer {
            padding: 20px 30px;
            text-align: center;
            color: #777;
            font-size: 14px;
            border-top: 1px solid #eee;
        }
        
        .thank-you {
            font-size: 18px;
            color: #ff6b6b;
            margin-bottom: 10px;
            font-weight: 600;
        }
        
        .item-name {
            font-weight: 600;
        }
        
        .item-desc {
            font-size: 13px;
            color: #777;
            margin-top: 3px;
        }
        
        .reset-link {
            display: block;
            margin: 20px 0;
            padding: 10px;
            background: #f0f0f0;
            border-left: 4px solid #ff6b6b;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="invoice-container">
        <div class="invoice-header">
            <h1 class="restaurant-name">Meal Matrix</h1>
            <h2 class="invoice-title">INVOICE</h2>
        </div>
        
        <div class="invoice-info">
            <div class="info-section">
                <div class="info-label">INVOICE</div>
                <div class="info-value">$invoiceno</div>
            </div>
            <div class="info-section">
                <div class="info-label">DATE</div>
                <div class="info-value">$today</div>
            </div>
            <div class="info-section">
                <div class="info-label">Time</div>
                <div class="info-value">$time</div>
            </div>
        </div>
        
        <table class="items-table">
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Name</th>
                    <th>Canteen</th>
                    <th>Qty</th>
                    <th>Price</th>
                </tr>
            </thead>
            <tbody>
HTML;

include_once "connection.php";

$sql2 = "SELECT oid,name,supply,qty FROM orders WHERE inno = ?";
$data2 = array($invoiceno);

$result2 = sqlsrv_query($conn, $sql2, $data2);
while($row2 = sqlsrv_fetch_array($result2, SQLSRV_FETCH_ASSOC)){
    $invoiceHTML .= <<<HTML
                <tr>
                    <td>{$row2['oid']}</td>
                    <td>
                        <div class="item-name">{$row2['name']}</div>
                    </td>
                    <td>{$row2['supply']}</td>
                    <td>{$row2['qty']}</td>
    HTML;

    
    $sql3 = "SELECT price FROM product WHERE supply = ? AND name = ?";
    $data3 = array($row2['supply'], $row2['name']);
    $result3 = sqlsrv_query($conn, $sql3, $data3);
    if($row3 = sqlsrv_fetch_array($result3, SQLSRV_FETCH_ASSOC)){
        $total = $total + ($row2['qty'] * $row3['price']);
        $invoiceHTML .= <<<HTML
                <td>Rs.{$row3['price']}</td>
            </tr>
            </tbody>
       </table>

       <div class="total-section">
         <div class="total-row grand-total">
            <span class="total-label">TOTAL</span>
            <span>Rs.$total</span>
         </div>
      </div>

    HTML;
    }
}

$invoiceHTML .= <<<HTML
            
        <div class="footer">
            <div class="thank-you">Thank you for using Meal Matrix</div>
            <p>Meal Matrix • Pitipana, Homagama</p>
            <p>Phone: +(94) 76 157 1745 • Email: MealMatrixCGP@outlook.com</p>
        </div>
    </div>
</body>
</html>
HTML;


// Create a new PHPMailer instance
$mail = new PHPMailer(true);

try {
    // Server settings
    $mail->isSMTP();
    $mail->Host = 'smtp.gmail.com';
    $mail->SMTPAuth = true;
    $mail->Username = 'supun200202@gmail.com';
    $mail->Password = 'wojr acvl halb mesm'; // Ensure you are using an App Password
    $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
    $mail->Port = 587;
    $mail->SMTPDebug = 2; // Enable debugging

    // Recipients
    $mail->setFrom('MealMatrixCGP@outlook.com', 'Meal-Matrix');
    $mail->addAddress($email);

    // Content
    $mail->isHTML(true);
    $mail->Subject = 'Purchase Invoice';
    $mail->Body = $invoiceHTML;

    // Send the email
    if ($mail->send()) {
        header("Location: http://192.168.177.67/FireBase/state/paymentsuccess.php?total=$total&invoice=$invoiceno");
    } else {
        echo json_encode(array("status" => "error", "message" => "Mail not sent"));
        http_response_code(500);
    }
} catch (Exception $e) {
    echo json_encode(array("status" => "error", "message" => "Mailer Error: {$mail->ErrorInfo}"));
    http_response_code(500);
}
?>