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