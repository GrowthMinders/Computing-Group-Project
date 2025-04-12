<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meal Matrix | Edit Product</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="css/editproduct.css" rel="stylesheet"> 
</head>
<body>
    <div class="main">
        <img src="Meal Matrix Logo.png" alt="Meal Matrix Logo">
        <h1>Edit Product</h1> 
        <form action="" method="POST">
            <div class="form-group">
                <i class="fas fa-tag input-icon"></i>
                <input type="text" name="name" id="name" placeholder="Name" value="Product Name">
            </div>
            
            <div class="form-group">
                <i class="fas fa-list input-icon"></i>
                <input type="text" name="category" id="category" placeholder="Category" value="Beverage">
            </div>
            
            <div class="form-group">
                <i class="fas fa-rupee-sign input-icon"></i>
                <input type="text" name="price" id="price" placeholder="Price" value="50.00">
            </div>
            
            <div class="form-group">
                <i class="fas fa-store input-icon"></i>
                <input type="text" name="canteen" id="canteen" placeholder="Canteen" value="Main Canteen">
            </div>
            
            <div class="form-group">
                <i class="fas fa-truck input-icon"></i>
                <input type="text" name="supply" id="supply" placeholder="Supplier" value="Beverage Suppliers Inc.">
            </div>
            
            <button type="submit">
                <i class="fas fa-sync-alt"></i> Update Product
            </button>
        </form>
    </div>
</body>
</html>