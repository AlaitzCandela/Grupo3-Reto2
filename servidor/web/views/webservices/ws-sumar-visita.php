<?php
    if (!isset($_POST["id_anuncio"])) die;

    require "../bbdd.php";

    $id_anuncio = $_POST["id_anuncio"];
    
    $dbh=connect(true);
    sumarVisita($dbh,$id_anuncio);    
    $dbh=close($dbh);
    
    die();