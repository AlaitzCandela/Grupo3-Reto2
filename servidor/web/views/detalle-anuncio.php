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


    if (!isset($_GET["id"])) {
        require './error-404.php';
        die();
    }
    
    $id_anuncio = $_GET["id"];
    

    // Propiedades del icono estrella (favoritos)
    $fav_icon_name  = "star-outline";
    $fav_icon_class = '';
    // Comprobamos si ya está en favoritos
    $ids_favoritos = explode(",", $_COOKIE["favoritos"]);
    if (in_array($id_anuncio, $ids_favoritos)) { // Si ya existe, 'coloreamos' la estrella (sin salirnos de los bordes)
        $fav_icon_name  = "star";
        $fav_icon_class = 'class="seleccionado"';
    }
    
    // Propiedades del icono estrella (carrito)
    $carrito_icon_name  = "bag-add-outline";
    $carrito_icon_class = '';
    // Comprobamos si ya está en carrito
    $ids_carrito = explode(",", $_COOKIE["carrito"]);
    if (in_array($id_anuncio, $ids_carrito)) { // Si ya existe, 'coloreamos' la estrella (sin salirnos de los bordes)
        $carrito_icon_name  = "bag-remove-outline";
        $carrito_icon_class = 'class="rojo"';
    }

    // Recogemos datos del anuncio
    $data = array("id"=>$id_anuncio);
    $dbh = connect();
    
    $datos = detalleAnuncio($dbh,$data);
    $dbh=close($dbh);

    // Si no existe, mostramos vista 404
    if ($datos == false) {
        require "./error-404.php";
        die();
    }

    // Mostramos la vista  
    $controlado = true;
    require "detalle-anuncio.view.php";


?>