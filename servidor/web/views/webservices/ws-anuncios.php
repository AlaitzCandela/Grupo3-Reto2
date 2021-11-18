<?php
    require "../bbdd.php";

    $id1 = 1;
    $id2 = 10;
    $data = array('id1'=>$id1,'id2'=>$id2);

    $dbh=connect();
    $anuncios = cogerAnuncios($dbh,$data);

    $dbh=close($dbh);

    header('Content-type:application/json');

    echo json_encode($anuncios);
    
    die();
  
    
