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
        <h1>Registered Suppliers</h1>
        <table>
            <thead>
                <tr>
                    <th>Profile Picture</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Contact</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <?php
                include_once "../connection.php";
                $sql = "SELECT name, email, contact, image FROM customer WHERE email LIKE '%@gmail.com'";
                $result = sqlsrv_query($conn, $sql);
     
                if($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC)) {
                    echo "<tr>
                            <td><img src='data:image/png;base64," . base64_encode($row['image']) . "' style='height:90px; width:90px; border-radius:20px;'></td>
                            <td>" . $row['name'] . "</td>
                            <td>" . $row['email'] . "</td>
                            <td>" . $row['contact'] . "</td>
                            <td>
                               <form action='backend/supplierdelete.php' method='POST'>
                                  <input type='text' name='email' value='" . $row['email'] . "' hidden>
                                  <button type='submit' class='action-btn delete-btn'>Delete</button>
                               </form>
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