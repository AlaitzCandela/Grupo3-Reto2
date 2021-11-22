<?php
    require "../bbdd.php";

    // TODO dani: switch filtro
    $filtro = "";

    $inicio = $_POST["inicio"];
    $fin = $_POST["fin"];
    
    $data = array('inicio'=>$inicio,'fin'=>$fin,'filtro'=>$filtro);

    $dbh=connect();
    $usuarios = cogerUsuarios($dbh,$data);
    $dbh=close($dbh);

    header('Content-type:application/json');

    echo json_encode($usuarios);
    
    die();
  
    
