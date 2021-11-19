<?php
    require "./bbdd.php";

    $nombreProducto = $_POST["nombre"];
    $descripcion = $_POST["descripcion"];
    $foto = $_POST["foto"];
    $precio = doubleval($_POST["precio"]);
    $tiempo_caducidad = intval($_POST["caducidad"]);
    $categoria = $_POST["categoria"];
    $id_anuncio = 0;


    $data = array('nombre' => $nombreProducto, 'descripcion' => $descripcion, 'foto' => $foto, 'precio' => $precio, 'tiempo_caducidad' => $tiempo_caducidad);

    $dbh=connect();
    $id_anuncio= insertarAnuncios($dbh,$data);
    $datos_categoriaAnuncios = array('id_anuncio'=>$id_anuncio,'id_categoria'=>$categoria);
    insertarCategoriaAnuncios($dbh,$datos_categoriaAnuncios);
    $dbh=close($dbh);


?>