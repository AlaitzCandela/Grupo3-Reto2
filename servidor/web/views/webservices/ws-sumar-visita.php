<?php
    if (!isset($_POST["id_anuncio"])) die();

    require "../bbdd.php";

    $id_anuncio = $_POST["id_anuncio"];
    
    $dbh=connect(true);
    $exito = sumarVisita($dbh,$id_anuncio);    
    $dbh=close($dbh);
    
    header('Content-type:application/json');

    $respuesta = [
        "exito" => $exito
    ];
    echo json_encode($respuesta);

    die();