<?php
$email = '';

// Check if the 'email' parameter exists in the URL
if (isset($_GET['email'])) {
  // Sanitize the email value to prevent XSS attacks
  $email = htmlspecialchars($_GET['email']);
}

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;700&display=swap" rel="stylesheet">
      <link rel="stylesheet" href="http://192.168.177.67/Firebase/web/ResetPassword.css" type="text/css" />
      <script src = "http://192.168.177.67/Firebase/web/validation.js"></script>
    <title>Reset Password</title>
    
</head>
<body>
    <div class="container">
        <div style="margin-bottom: 50px;">
            <center><label class="top">New Password</label></center>
        </div>
        <div style="margin-bottom: 40px;" id="errdisplay" hidden>
            
        </div>
        <form name="reset" action="http://192.168.177.67/Firebase/web/updatepassword.php" method="POST">
            <div style="margin-bottom: 50px;">
                <label class="lab">Enter New Password</label>
            <input type="password" name="pass" id="pass" placeholder="Abcd@123">
            </div>
            <div style="margin-bottom: 80px;">
            <label class="lab">Confirm Password</label>
            <input type="password" name="cpass" id="cpass" placeholder="Abcd@123">
            </div>
            <input type="text" name="email" id="email" value="<?php echo $email; ?>" hidden>
            <input type="button" value="Send" onclick="validate();">
        </form>
    </div>
</body>
</html>