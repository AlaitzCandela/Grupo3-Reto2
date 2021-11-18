<?php
    require "./bbdd.php";

    $nombreProducto = $_POST["nombre"];
    $descripcion = $_POST["descripcion"];
    $foto = $_POST["foto"];
    $precio = $_POST["precio"];
    $tiempo_caducidad = $_POST["caducidad"];

    $data = array('nombre' => $nombreProducto,'descripcion'=>$descripcion,'foto'=>$foto,'precio'=>$precio,'tiempo_caducidad'=>$tiempo_caducidad);

    $dbh=connect();
    insertarAnuncios($dbh,$data);
    $dbh=close($dbh);


?>