<?php
    require "./bbdd.php";
    
    // Obtenemos el tipo a la par que comprobamos que el usuario sigue loggeado
    $tipo = obtenerTipoUsuario();

    if (!isset($_GET["id"])) {
        require './error-404.php';
        die();
    }

    // Recibir GET con id de usuario a visualizar
    $dbh=connect();
    $data = array("id"=>$_GET["id"]);
    $datos_usuario = datosUsuario($dbh,$data);
    $dbh = close($dbh);

    // Por defecto no se puede editar el perfil
    $disabled = true;

    $id_usuario = $_COOKIE["id_usuario"];
    // Excepto si es tu propio perfil o si eres el administrador
    if ($datos_usuario["id"] == $id_usuario || $tipo == 'A') $disabled = false;
    

    // Mostrar vista
    require './perfil.view.php';


