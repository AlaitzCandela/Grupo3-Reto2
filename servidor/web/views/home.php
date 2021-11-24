<?php
    require "./bbdd.php";
    // Coger ID / token del usuario registrado
    $id_usuario = $_COOKIE["id_usuario"];
    // Comprobar en la BBDD el tipo de usuario
    $dbh=connect();
    $data = array("id"=>$id_usuario);
    $tipo = cogerTipoUsuario($dbh,$data);
    $dbh=close($dbh);

    if($tipo == false){
        require "./login.view.php";
        die();
    }
 
    // Redireccionar al usuario en base a su tipo
    if($tipo == "A") {
        // Si es administrador: cargar mini panel
        // TODO: implementar administracion anuncios formato tabla (?)
        require "./usuarios.view.php";
    }
    else if($tipo == "C"){
        // Si es cliente: cargar página anuncios
        require './anuncios.view.php';
    }
    else{
        // Si es vendedor: cargar página estadísticas
        require './home-vendedor.view.php';
    }





