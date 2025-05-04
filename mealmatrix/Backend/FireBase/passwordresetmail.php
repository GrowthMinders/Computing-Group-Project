<?php
// Enable error reporting
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Include PHPMailer autoload
require 'C:/xampp/htdocs/FireBase/vendor/autoload.php';

require 'PHPMailer/src/Exception.php';
require 'PHPMailer/src/PHPMailer.php';
require 'PHPMailer/src/SMTP.php';

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

// Get the email from the POST request
$email = $_POST['email'];

// Check if the email is empty
if (empty($email)) {
    error_log('Email Empty (passwordresetmail)'); // Log the error
    http_response_code(400); // Bad request
    log(2);
    exit(); // Stop further execution
}

// Create the password reset link
$message = "http://192.168.8.101/Firebase/passwordreset.php?email=" . urlencode(string: $email);

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
    $mail->setFrom('supun200202@gmail.com', 'Supun Silva');
    $mail->addAddress($email);

    // Content
    $mail->isHTML(false);
    $mail->Subject = 'Password Resetting';
    $mail->Body = "Please confirm your identity and reset your password:\n" . $message;

    // Send the email
    if ($mail->send()) {
        echo json_encode(array("status" => "success", "message" => "Message has been sent"));
        http_response_code(200);
    } else {
        echo json_encode(array("status" => "error", "message" => "Mail not sent"));
        http_response_code(500);
    }
} catch (Exception $e) {
    echo json_encode(array("status" => "error", "message" => "Mailer Error: {$mail->ErrorInfo}"));
    http_response_code(500);
}
?>