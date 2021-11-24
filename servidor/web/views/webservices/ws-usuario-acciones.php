<?php
    require "../bbdd.php";

    $id = $_POST["id"];
    
    $data = array('id'=>$id);
    $exito = false;
    $datos_usuario = [];

    $dbh=connect(true);
    if ($_POST["accion"] == "deshabilitar") $exito = deshabilitarUsuario($dbh,$data);
    else if ($_POST["accion"] == "habilitar") $exito = habilitarUsuario($dbh,$data);
    else if ($_POST["accion"] == "eliminar") $exito = eliminarUsuario($dbh,$data);
    else if ($_POST["accion"] == "obtener") {
        $datos_usuario = datosUsuario($dbh,$data);
        if ($datos_usuario != null && $datos_usuario != "") $exito = true;
    } 
        
    $dbh=close($dbh);

    header('Content-type:application/json');

    $respuesta = [
        "exito" => $exito,
        "datos_usuario" => $datos_usuario
    ];
    echo json_encode($respuesta);
    
    die();