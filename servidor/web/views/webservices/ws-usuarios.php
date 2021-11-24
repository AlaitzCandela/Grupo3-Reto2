<?php
    require "../bbdd.php";

    // Parseamos el filtro
    $filtro = "WHERE tipo IN (";
    $filtro_tipo = $_POST["filtro_tipo"];
    switch ($filtro_tipo) {
        case 'A':
        case 'V':
        case 'C':
            $filtro .= "'$filtro_tipo'";
            break;
        default:
            $filtro .= "'A', 'C', 'V'";
    }
    $filtro .= ") ";

    $filtro_nombre = $_POST["filtro_nombre"];
    if ($filtro_nombre != "") {
        $filtro_nombre = filter_var($filtro_nombre, FILTER_SANITIZE_STRING);
        $filtro .= "AND username LIKE '%$filtro_nombre%' ";
    }

    $inicio = $_POST["inicio"];
    $fin = $_POST["fin"];
    
    $data = array('inicio'=>$inicio,'fin'=>$fin,'filtro'=>$filtro);

    $dbh=connect(true);
    $usuarios = cogerUsuarios($dbh,$data);
    $dbh=close($dbh);

    header('Content-type:application/json');

    echo json_encode($usuarios);
    
    die();
  
    
