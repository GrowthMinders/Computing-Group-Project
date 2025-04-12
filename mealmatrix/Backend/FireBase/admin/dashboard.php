<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meal Matrix | Admin Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="css/dashboard.css" rel="stylesheet">
</head>
<body>
    <div class="sidebar">
        <div class="logo">
            <img src="Meal Matrix Logo.png" alt="Meal Matrix">
        </div>
        <ul class="nav-menu">
            <li class="nav-item">
                <a href="dashboard.php" class="nav-link active">
                    <i class="fas fa-tachometer-alt"></i>
                    <span>Dashboard</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="register.php" class="nav-link">
                    <i class="fas fa-plus-circle"></i>
                    <span>Add Canteen</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="product.php" class="nav-link">
                    <i class="fas fa-utensils"></i>
                    <span>Add Product</span>
                </a>
            </li>
        </ul>
        
       
        <div class="logout-container">
            <a href="admin-login.html" class="logout-btn">
                <i class="fas fa-sign-out-alt"></i>
                <span>Log Out</span>
            </a>
        </div>
    </div>
    

    <div class="main-content">
        <div class="header">
            <h1 class="page-title">Dashboard</h1>
            <div class="user-profile">
                <img src="https://randomuser.me/api/portraits/women/45.jpg" alt="User">
                <span>Admin</span>
            </div>
        </div>

        
        <div class="dashboard-cards">
            <div class="card card-1">
                <div class="card-icon">
                    <i class="fas fa-store"></i>
                </div>
                <p class="card-title">Total Canteens</p>
                <p class="card-value">12</p>
            </div>
            <div class="card card-2">
                <div class="card-icon">
                    <i class="fas fa-utensils"></i>
                </div>
                <p class="card-title">Total Products</p>
                <p class="card-value">87</p>
            </div>
            <div class="card card-3">
                <div class="card-icon">
                    <i class="fas fa-users"></i>
                </div>
                <p class="card-title">Registered Users</p>
                <p class="card-value">256</p>
            </div>
        </div>
    </div>
</body>
</html>