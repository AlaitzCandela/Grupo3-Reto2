<?php

    // Si el método POST no indica la acción register, devolvemos json error
    if ($_POST["accion"] != "registrar-vendedor") { 
        header('Content-type: application/json');
        echo json_encode(["codError" => 400, "error" => "Bad request"]);
        die();
    }

    require "../bbdd.php";

    $data = [
        "id" => $_POST["id_usuario"],
        "telefono" => $_POST["telefono"],
        "direccion" => $_POST["direccion"]
    ];

    $dbh=connect(true);
    $exito = registrarVendedor($dbh, $data);
    $dbh=close($dbh);

    header('Content-type:application/json');

    $respuesta = [
        "exito" => $exito
    ];
    echo json_encode($respuesta);
    
    die();