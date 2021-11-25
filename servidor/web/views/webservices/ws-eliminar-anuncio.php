<?php

    if ($_POST["accion"] != "eliminar-anuncio") {
        header('Content-type: application/json');
        echo json_encode(["codError" => 400, "error" => "Bad request"]);
        die();
    }

    require "../bbdd.php";
    $id_anuncio = $_POST["id_anuncio"];
    
    $data = array('id'=>$id_anuncio);

    $dbh=connect(true);
    $exito = eliminarAnuncio($dbh,$data,true);
    $dbh=close($dbh);

    header('Content-type:application/json');
    echo json_encode(["exito" => $exito]);
    
    die();