<?php

// Comprobamos si ha cerrado sesión
if (isset($_GET["logout"])) {
    require './bbdd.php';
    limpiarCookiesUsuario();
}

// Comprobar si ya está loggeado
if (isset($_COOKIE["id_usuario"])) {
    header ("location: .\home.php");
    die();
}

// Mostrar vista
require './login.view.php';