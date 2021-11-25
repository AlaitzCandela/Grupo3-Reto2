<?php

    require "./bbdd.php";

    // Obtenemos el tipo a la par que comprobamos que el usuario sigue loggeado
    $tipo = obtenerTipoUsuario();
    
    $dbh=connect();
    $productos_carrito = [];
    $precio_total = 0.00;
    if (isset($_COOKIE["carrito"])) {
        $productos_carrito = detallesAnunciosCarrito($dbh, $_COOKIE["carrito"]);
        if ($productos_carrito) {
            $precio_total = array_reduce($productos_carrito, function($total, $producto) {
                return $total + $producto["precio"];
            });
        }
    }
   
    $dbh=close($dbh);

    require "./carrito.view.php";