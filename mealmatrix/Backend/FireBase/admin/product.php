<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meal Matrix | New Product</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="css/product.css" rel="stylesheet"> 
</head>
<body>
    <div class="main">
        <img src="Meal Matrix Logo.png" alt="Meal Matrix Logo">
        <h1>New Product</h1> 
        <form action="" method="POST">
            <div class="input-group">
                <i class="fas fa-tag input-icon"></i>
                <input type="text" name="name" id="name" placeholder="Name">
            </div>
            
            <div class="input-group">
                <i class="fas fa-list input-icon"></i>
                <input type="text" name="category" id="category" placeholder="Category">
            </div>
            
            <div class="input-group">
                <i class="fas fa-dollar-sign input-icon"></i>
                <input type="text" name="price" id="price" placeholder="Price">
            </div>
            
            <div class="input-group">
                <i class="fas fa-image input-icon"></i>
                <input type="text" name="image" id="image" placeholder="Product Image URL">
            </div>
            
            <div class="input-group">
                <i class="fas fa-store input-icon"></i>
                <input type="text" name="canteen" id="canteen" placeholder="Canteen">
            </div>
            
            <div class="input-group">
                <i class="fas fa-truck input-icon"></i>
                <input type="text" name="supply" id="supply" placeholder="Supplier">
            </div>
            
            <button type="submit">
                <i class="fas fa-plus-circle"></i>
                Add Product
            </button>
        </form>
    </div>
</body>
</html>