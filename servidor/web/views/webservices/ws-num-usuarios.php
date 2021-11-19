<?php
    require "../bbdd.php";
   
    $dbh=connect();
    $num_usuarios = numeroUsuariosRegistrados($dbh);
    $dbh=close($dbh);

    header('Content-type:application/json');

    echo json_encode($num_usuarios);
    
    die();
  
    
