<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meal-Matrix</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link href="css/tables.css" rel="stylesheet"> 
</head>
<body>
    <div class="container">
        <h1>Registered Products</h1>
        <table>
            <thead>
                <tr>
                    <th>Image</th>
                    <th>Name</th>
                    <th>Category</th>
                    <th>Price</th>
                    <th>Location</th>
                    <th>Supplier</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <?php
                include_once "../connection.php";
                $sql = "SELECT * FROM product";
                $result = sqlsrv_query($conn, $sql);
     
                while($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC)) {
                    echo "<tr>
                            <td><img src='". $row['image'] ."' style='height:120px; width:120px; border-radius:20px;'></td>
                            <td>". $row['name'] ."</td>
                            <td>". $row['category'] ."</td>
                            <td>Rs. ". $row['price'] ."</td>
                            <td>". $row['canteen'] ."</td>
                            <td>". $row['supply'] ."</td>
                            <td>
                              <div style='display: flex;'>
                                <form action='editproduct.php' method='POST'>
                                    <input type='text' name='pid' id='pid' value='". $row['pid'] ."' hidden>
                                    <button type = 'submit' class='action-btn edit-btn'>Edit</button>
                                </form>
                                <form action='backend/productdelete.php' method='POST'>
                                    <input type='text' name='pid' id='pid' value='". $row['pid'] ."' hidden>
                                    <button type = 'submit' class='action-btn delete-btn'>Delete</button>
                                </form>
                              </div> 
                            </td>
                         </tr>";
                } 
                sqlsrv_free_stmt($result);
                sqlsrv_close($conn);
                ?>
            </tbody>
        </table>
    </div>
</body>
</html>