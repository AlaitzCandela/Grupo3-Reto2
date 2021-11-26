<?php

    // Si el método POST no indica la acción register, devolvemos json error
    if ($_POST["accion"] != "comprobar-usuario") { 
        header('Content-type: application/json');
        echo json_encode(["codError" => 400, "error" => "Bad request"]);
        die();
    }

    require "../bbdd.php";
    $username = $_POST["username"];
    

    $dbh=connect(true);
    $existe = usuarioExiste($dbh,$username);
    $dbh=close($dbh);

    header('Content-type:application/json');
    echo json_encode(["existe" => $existe]);
    
    die();

