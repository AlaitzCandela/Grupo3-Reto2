<?php
    require "./bbdd.php";
    
    // Obtenemos el tipo a la par que comprobamos que el usuario sigue loggeado
    $tipo = obtenerTipoUsuario();
    
    require './anuncios.view.php';