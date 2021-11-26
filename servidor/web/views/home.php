<?php
    require "./bbdd.php";
    
    // Obtenemos el tipo a la par que comprobamos que el usuario sigue loggeado
    $tipo = obtenerTipoUsuario();
    
    // Redireccionar al usuario en base a su tipo
    if ($tipo == "A") {
        // Si es administrador: cargar página administración de usuarios
        $permiso_admin = true;
        require "./usuarios.view.php";
    } else if ($tipo == "C") {
        // Si es cliente: cargar página de anuncios
        header ("location: ./anuncios.php");
        die();
    } else {
        // Si es vendedor: cargar página de perfil y estadísticas
        header ("location: ./home-vendedor.php?id=". $_COOKIE["id_usuario"]);
        die();
    }

