<?php

    require "./bbdd.php";

    // Obtenemos el tipo a la par que comprobamos que el usuario sigue loggeado
    $tipo = obtenerTipoUsuario();

    $dbh=connect();
    $categorias = cogerCategorias($dbh);
    $dbh=close($dbh);
    
    require './anuncios.view.php';