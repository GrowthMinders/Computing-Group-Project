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
            <a href="backend/logout.php" class="logout-btn">
                <i class="fas fa-sign-out-alt"></i>
                <span>Log Out</span>
            </a>
        </div>
    </div>
    

    <div class="main-content">
    <div class="header">
    <h1 class="page-title">Dashboard</h1>
    <div class="user-profile">
        <?php 
        session_start();
        include_once "../connection.php";

        $sql = "SELECT image FROM customer WHERE email = ?";
        $data = array($_SESSION["admin"]);

        $result = sqlsrv_query($conn, $sql, $data);

        if($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC)) {
            echo "<img src='https://randomuser.me/api/portraits/women/45.jpg' alt='admin'>";
        } else {
            echo "<img src='https://randomuser.me/api/portraits/women/45.jpg' alt='admin'>";//change
        }
        ?>
        
        <span><?php echo($_SESSION["admin"])?></span>
    </div>
</div>
        
<div class="dashboard-cards">
    <a href="listcanteen.php" class="next"><div class="card card-1">
        <div class="card-icon">
            <i class="fas fa-store"></i>
        </div>
        <p class="card-title">Total Canteens</p>
        <?php 
           include_once "../connection.php";
           $sql = "SELECT COUNT(*) AS count FROM canteen";
           $result = sqlsrv_query($conn, $sql);

           if($result && $row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC)) {
               echo "<p class='card-value'>".$row['count']."</p>";
           } else {
               echo "<p class='card-value'>0</p>";
           }
           sqlsrv_free_stmt($result);
        ?>
        
    </div></a>

    <a href="listsupplier.php" class="next"><div class="card card-3">
        <div class="card-icon">
            <i class="fas fa-users"></i>
        </div>
        <p class="card-title">Suppliers</p>
        <?php 
           include_once "../connection.php";
           $sql1 = "SELECT COUNT(*) AS count FROM customer WHERE email LIKE '%@gmail.com'";
           $result1 = sqlsrv_query($conn, $sql1);

           if($result1 && $row1 = sqlsrv_fetch_array($result1, SQLSRV_FETCH_ASSOC)) {
               echo "<p class='card-value'>".$row1['count']."</p>";
           } else {
               echo "<p class='card-value'>0</p>";
           }
           sqlsrv_free_stmt($result1);
        ?>
        
    </div></a>

    <a href="listproduct.php" class="next"><div class="card card-2">
        <div class="card-icon">
            <i class="fas fa-utensils"></i>
        </div>
        <p class="card-title">Total Products</p>
        <?php 
           include_once "../connection.php";
           $sql2 = "SELECT COUNT(*) AS count FROM product";
           $result2 = sqlsrv_query($conn, $sql2);

           if($result2 && $row2 = sqlsrv_fetch_array($result2, SQLSRV_FETCH_ASSOC)) {
               echo "<p class='card-value'>".$row2['count']."</p>";
           } else {
               echo "<p class='card-value'>0</p>";
           }
           sqlsrv_free_stmt($result2);
        ?>
        
    </div></a>

    <div class="card card-3">
        <div class="card-icon">
            <i class="fas fa-users"></i>
        </div>
        <p class="card-title">Registered Users</p>
        <?php 
           include_once "../connection.php";
           $sql3 = "SELECT COUNT(*) AS count FROM customer";
           $result3 = sqlsrv_query($conn, $sql3);

           if($result3 && $row3 = sqlsrv_fetch_array($result3, SQLSRV_FETCH_ASSOC)) {
               echo "<p class='card-value'>".$row3['count']."</p>";
           } else {
               echo "<p class='card-value'>0</p>";
           }
           sqlsrv_free_stmt($result3);
           sqlsrv_close($conn);
        ?>
    </div>
</div>
    </div>
</body>
</html>