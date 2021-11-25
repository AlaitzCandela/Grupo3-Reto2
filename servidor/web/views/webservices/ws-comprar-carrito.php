<?php

    if ($_POST["accion"] != "comprar-carrito") {
        header('Content-type: application/json');
        echo json_encode(["codError" => 400, "error" => "Bad request"]);
        die();
    }

    require "../bbdd.php";
    
    // Conectamos BBDD
    $dbh=connect(true);

    // Inicializamos la respuesta
    $respuesta_json = [
        "exito" => true,
        "codError" => 0
    ];


    $data = [
        "id_comprador" => $_POST["id_comprador"],
        "id_anuncios" => $_POST["id_anuncios"]
    ];
    $result=comprarProductos($dbh, $data);
    
    // Cerramos conexión
    $dbh=close($dbh);

    // Devolvemos respuesta
    header('Content-type: application/json');
    echo json_encode($result);
    die();   

?>