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

    require "./carrito.view.php";