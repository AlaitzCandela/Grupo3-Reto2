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

    // Recibir GET con id de usuario a visualizar
    if (isset($_GET["id"])) {
        $dbh=connect();
        $data = array("id"=>$_GET["id"]);
        $datos_usuario = datosUsuario($dbh,$data);
        $dbh = close($dbh);

        // Por defecto no se puede editar el perfil
        $disabled = true;

        // Excepto si es tu propio perfil o si eres el administrador
        if ($datos_usuario["id"] == $id_usuario || $tipo == 'A') $disabled = false;
    } else {
        require './error-404.php';
        die();
    }

    // Mostrar vista
    require './perfil.view.php';


