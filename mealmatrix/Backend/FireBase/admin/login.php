<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meal Matrix | Admin Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="css/login.css" rel="stylesheet"> 
</head>
<body>
    <div class="main">
        <div class="logo-container">
            <img src="Meal Matrix Logo.png" alt="Meal Matrix Logo">
            <h1>Welcome Back, Admin</h1>
            <p class="subtitle">Please enter your credentials to continue</p>
        </div>
        
        <form action="" method="POST">
            <div class="form-group">
                <i class="icon">📧</i>
                <input type="email" name="email" id="email" placeholder="Email Address" required>
            </div>
            
            <div class="form-group">
                <i class="icon">🔒</i>
                <input type="password" name="pass" id="pass" placeholder="Password" required>
            </div>
            
            <button type="submit">Login</button>
        </form>
    </div>
</body>
</html>