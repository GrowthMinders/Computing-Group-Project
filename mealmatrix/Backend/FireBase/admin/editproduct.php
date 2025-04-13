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
        <form action="backend/productupdate.php" method="POST">
            <?php
                include_once "../connection.php";

                $id = $_POST['pid'];

                $sql = "SELECT * FROM product WHERE pid = ?";

                $data = array($id);

                $result = sqlsrv_query($conn, $sql, $data);
     
                while($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC)) {
                    echo "<div class='form-group'>
                             <i class='fas fa-pencil-alt input-icon'></i>
                             <input type='text' name='name' id='name' value='". $row['name'] ."'>
                          </div>

                          <div class='form-group'>
                             <i class='fas fa-tags input-icon'></i>
                             <input type='text' name='category' id='category' value='". $row['category'] ."'>
                          </div>

                          <div class='form-group'>
                             <i class='fas fa-money-bill-wave input-icon'></i>
                             <input type='text' name='price' id='price' value='". $row['price'] ."'>
                          </div>

                          <div class='form-group'>
                             <i class='fas fa-utensils input-icon'></i>
                             <input type='text' name='canteen' id='canteen' value='". $row['canteen'] ."'>
                          </div>

                          <div class='form-group'>
                             <i class='fas fa-boxes input-icon'></i>
                             <input type='text' name='supply' id='supply' value='". $row['supply'] ."'>
                          </div>

                          <input type='text' name='pid' id='pid' value='". $row['pid'] ."' hidden>
                          
                          <button type='submit'><i class='fas fa-save'></i> Update Product </button>";
                } 
                sqlsrv_free_stmt($result);
                sqlsrv_close($conn);
                ?>
        </form>
    </div>
</body>
</html>