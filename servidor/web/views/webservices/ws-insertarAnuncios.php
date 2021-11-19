<?php
    require "../bbdd.php";

    $dbh=connect();
    $categorias = cogerCategorias($dbh);
    $dbh=close($dbh);

    // Definimos en los headers el tipo de contenido (que será JSON)
    header('Content-type: application/json');

    // Devolvemos el resultado
    echo json_encode($categorias);

    // Finalizamos el resto de la ejecución :)
    die();   
?>