<?php

    require "../bbdd.php";
    $inicio = $_POST["inicio"];
    $fin = $_POST["fin"];
    $filtro = $_POST["filtro"];
    
    $data = array('inicio'=>$inicio,'fin'=>$fin);

    $dbh=connect(true);
    $anuncios = cogerAnuncios($dbh,$data);
    $dbh=close($dbh);

    header('Content-type:application/json');

    echo json_encode($anuncios);
    
    die();
  
    
