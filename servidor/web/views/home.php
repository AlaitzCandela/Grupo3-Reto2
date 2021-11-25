<?php
    require "./bbdd.php";
    
    // Comprobamos si hay usuario loggeado y si aún está habilitado
    usuarioLoggeadoYHabilitado();

    // Coger ID / token del usuario registrado
    $id_usuario = $_COOKIE["id_usuario"];
    // Comprobar en la BBDD el tipo de usuario
    $dbh=connect();
    $data = array("id"=>$id_usuario);
    $tipo = cogerTipoUsuario($dbh,$data);
    $dbh=close($dbh);
    
    // Redireccionar al usuario en base a su tipo
    if ($tipo == "A") {
        // Si es administrador: cargar página administración de usuarios
        $permiso_admin = true;
        require "./usuarios.view.php";
    }
    else if ($tipo == "C") {
        // Si es cliente: cargar página de anuncios
        require './anuncios.view.php';
    }
    else {
        // Si es vendedor: cargar página de perfil y estadísticas
        require './home-vendedor.view.php';
    }





