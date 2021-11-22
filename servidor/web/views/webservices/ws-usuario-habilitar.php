<?php
    require "../bbdd.php";

    $id = $_POST["id"];
    
    $data = array('id'=>$id);
    $exito = false;

    $dbh=connect();
    if ($_POST["accion"] == "deshabilitar") $exito = deshabilitarUsuario($dbh,$data);
    else if ($_POST["accion"] == "habilitar") $exito = habilitarUsuario($dbh,$data);
    $dbh=close($dbh);

    header('Content-type:application/json');

    $respuesta = [
        "exito" => $exito
    ];
    echo json_encode($respuesta);
    
    die();