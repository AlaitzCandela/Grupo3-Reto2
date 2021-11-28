<?php
    require "./bbdd.php";

    // Obtenemos el tipo a la par que comprobamos que el usuario sigue loggeado
    $tipo = obtenerTipoUsuario();
    
    $id_usuario = $_COOKIE["id_usuario"];

    // Recogemos los anuncios
    $dbh=connect();
    $anuncios = obtenerHistorial($dbh,$id_usuario,$tipo);
    $dbh=close($dbh);
    if ($anuncios == null) $anuncios = [];

    // Mostramos la vista  
    require "historial.view.php";


?>