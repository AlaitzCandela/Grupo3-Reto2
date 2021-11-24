<?php
    require "./bbdd.php";
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

    // Recogemos datos del anuncio
    $data = array("id"=>$id_anuncio);
    $dbh = connect();
    $datos = detalleAnuncio($dbh,$data);
    $dbh=close($dbh);

    // Si no existe, mostramos vista 404
    if ($datos == false) {
        require "./error-404.view.php";
        die();
    }

    // Mostramos la vista
    require "detalle-anuncio.view.php";


?>