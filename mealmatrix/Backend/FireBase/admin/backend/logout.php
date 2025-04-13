<?php
session_start();

$_SESSION["admin"] = "";
header("Location: ../login.php");

?>