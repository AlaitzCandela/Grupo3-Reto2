<?php
    require "../bbdd.php";
   
    $dbh=connect(true);
    $num_usuarios = numeroUsuariosRegistrados($dbh);
    $dbh=close($dbh);

    header('Content-type:application/json');

    echo json_encode($num_usuarios);
    
    die();
  
    
