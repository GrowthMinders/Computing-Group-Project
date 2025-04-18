<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meal-Matrix</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link href="css/tables.css" rel="stylesheet"> 
    <script>
        function confirm(){
            Swal.fire({
              title: 'Are you sure?',
              text: "The canteen will be deleted permenantly",
              icon: 'warning',
              showCancelButton: true,
              confirmButtonColor: '#3085d6',
              cancelButtonColor: '#d33',
              confirmButtonText: 'Proceed'
            }).then((result) => {
                if (result.isConfirmed) {
                   Swal.fire(
                      'Deleted!',
                      'Your file has been deleted.',
                      'success'
                   )
                   document.forms["supplier"].submit();
                }
            });
        }
    </script>   
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
                               <form name='supplier' action='backend/supplierdelete.php' method='POST'>
                                  <input type='text' name='email' value='" . $row['email'] . "' hidden>
                                  <button type = 'button' class='action-btn delete-btn' onclick='confirm();'>Delete</button>
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