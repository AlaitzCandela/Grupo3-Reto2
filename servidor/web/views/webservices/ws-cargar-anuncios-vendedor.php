<?php

    if ($_POST["accion"] != "cargar-anuncios-vendedor") {
        header('Content-type: application/json');
        echo json_encode(["codError" => 400, "error" => "Bad request"]);
        die();
    }

    require "../bbdd.php";
    $id_vendedor = $_POST["id_vendedor"];
    
    $data = array('id_vendedor'=>$id_vendedor);

    $exito = true;
    $dbh=connect(true);
    $anuncios = cargarAnunciosVendedor($dbh,$data);
    if ($anuncios == null) {
        $exito = false;
    }
    $dbh=close($dbh);

    header('Content-type:application/json');
    echo json_encode(["exito" => $exito, "anuncios" => $anuncios]);
    
    die();