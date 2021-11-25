<?php

    require "./bbdd.php";
        
    // Obtenemos el tipo a la par que comprobamos que el usuario sigue loggeado
    $tipo = obtenerTipoUsuario();

    // Mostrar vista
    require './subir-anuncio.view.php';

