<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meal Matrix | New Canteen</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="css/canteen.css" rel="stylesheet">  
</head>
<body>
    <div class="main">
        <div class="logo-container">
            <img src="Meal Matrix Logo.png" alt="Meal Matrix Logo">
            <h1>Register New Canteen</h1>
        </div>
        
        <form action="" method="POST" enctype="multipart/form-data">
            <div class="form-grid">
                <div class="form-group full-width">
                    <label for="name">Canteen Name</label>
                    <i class="fas fa-utensils input-icon"></i>
                    <input type="text" name="cname" id="cname" placeholder="e.g., Campus Cafeteria" required>
                </div>
                
                <div class="form-group full-width">
                    <label for="image">Canteen Image/Logo</label>
                    <div class="file-input-wrapper">
                        <div class="file-input-text">
                            <i class="fas fa-image"></i>
                            <span>Choose an image file...</span>
                        </div>
                        <input type="file" name="image" id="image" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="manager_name">Manager Name</label>
                    <i class="fas fa-user input-icon"></i>
                    <input type="text" name="name" id="name" placeholder="e.g., John Doe" required>
                </div>
                
                <div class="form-group">
                    <label for="contact">Contact Number</label>
                    <i class="fas fa-phone input-icon"></i>
                    <input type="tel" name="contact" id="contact" placeholder="e.g., +91 9876543210" required>
                </div>
                
                <div class="form-group">
                    <label for="otime">Opening Time</label>
                    <i class="far fa-clock input-icon"></i>
                    <input type="text" name="otime" id="otime" placeholder="e.g., 10:00" required>
                </div>
                
                <div class="form-group">
                    <label for="ctime">Closing Time</label>
                    <i class="far fa-clock input-icon"></i>
                    <input type="text" name="ctime" id="ctime" placeholder="e.g., 00:10" required>
                </div>
                
                <div class="form-group full-width">
                    <label for="location">Location</label>
                    <i class="fas fa-map-marker-alt input-icon"></i>
                    <input type="text" name="location" id="location" placeholder="e.g., Building A, Ground Floor" required>
                </div>
                
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <i class="fas fa-envelope input-icon"></i>
                    <input type="email" name="email" id="email" placeholder="e.g., contact@canteen.com" required>
                </div>
                
                <div class="form-group">
                    <label for="pass">Password</label>
                    <i class="fas fa-lock input-icon"></i>
                    <input type="password" name="pass" id="pass" placeholder="Create a password" required>
                </div>
                
                <div class="form-group">
                    <label for="confirm_pass">Confirm Password</label>
                    <i class="fas fa-lock input-icon"></i>
                    <input type="password" name="cpass" id="cpass" placeholder="Confirm your password" required>
                </div>
            </div>
            
            <button type="submit">
                <i class="fas fa-plus-circle"></i> Add Canteen
            </button>
        </form>
    </div>
</body>
</html>