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
        <h1>Registered Canteens</h1>
        <table>
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Open Time</th>
                    <th>Close Time</th>
                    <th>Location</th>
                    <th>Contact</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <?php
                include_once "../connection.php";
                $sql = "SELECT name, otime, ctime, location, contact FROM canteen";
                $result = sqlsrv_query($conn, $sql);
     
                if($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC)) {
                    echo "<tr>
                            <td>". $row['name'] ."</td>
                            <td>". $row['otime'] ."</td>
                            <td>". $row['ctime'] ."</td>
                            <td>". $row['location'] ."</td>
                            <td>". $row['contact'] ."</td>
                            <td>
                                <form action='backend/canteendelete.php' method='POST'>
                                    <input type='text' name='name' id='name' value='". $row['name'] ."' hidden>
                                    <button type = 'submit' class='action-btn delete-btn'>Delete</button>
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