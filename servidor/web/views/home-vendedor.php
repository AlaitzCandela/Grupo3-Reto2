<?php

    // Nota:
    // Por falta de tiempo, no se ha podido refactorizar estos métodos de queries a la BBDD y llevarlos al fichero BBDD
    // 😥😥😔😔😢😢😭😭😡😡🤬🤬 (╯°□°）╯︵ ┻━┻

    require "./bbdd.php";

    // Obtenemos el tipo a la par que comprobamos que el usuario sigue loggeado
    $tipo = obtenerTipoUsuario();

    if (!isset($_GET["id"])) {
        require './error-404.php';
        die();
    }
    
    $id_vendedor = $_GET["id"];

    $dbh=connect();
    $tipo_usuario = cogerTipoUsuario($dbh,["id" => $id_vendedor]);
    if ($tipo_usuario != 'V') { // Si no es el perfil de un vendedor, no queremos saber nada de la página
        require './error-404.php';
        $dbh=close($dbh);
        die();
    } 

    // Si es el propio usuario quien mira su propio perfil, podrá borrar anuncios (el admin también podrá)
    $privilegios_borrar = false;
    if ($id_vendedor == $_COOKIE["id_usuario"]) $privilegios_borrar = true;

    // Cargamos datos para estadísticas
    // num visitas totales
    $stmt = $dbh->prepare("SELECT sum(num_visitas) as num_visitas_totales FROM anuncios WHERE id_vendedor = $id_vendedor GROUP BY id_vendedor");
    $stmt->execute();
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    $num_visitas_totales = $result["num_visitas_totales"]; 
    if ($num_visitas_totales == null) $num_visitas_totales = 0;
    // num beneficios totales
    $stmt = $dbh->prepare("SELECT sum(precio) as ganancias_totales FROM anuncios WHERE vendido = 1 AND id_vendedor = $id_vendedor GROUP BY id_vendedor");
    $stmt->execute();
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    $ganancias_totales = $result["ganancias_totales"]; 
    if ($ganancias_totales == null) $ganancias_totales = 0;
    // num ventas totales
    $stmt = $dbh->prepare("SELECT count(id) as num_ventas_totales FROM anuncios WHERE vendido = 1 AND id_vendedor = $id_vendedor");
    $stmt->execute();
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    $num_ventas_totales = $result["num_ventas_totales"];
    if ($num_ventas_totales == null) $num_ventas_totales = 0;

    // Arrays para gráficas
    // num ganancias por mes
    $stmt = $dbh->prepare("SELECT MONTH(fecha_publicacion) AS mes, SUM(precio) AS total_ganancias FROM anuncios WHERE YEAR(fecha_publicacion) = YEAR(NOW()) AND id_vendedor = $id_vendedor AND vendido = 1 GROUP BY MONTH(fecha_publicacion) ORDER BY MONTH(fecha_publicacion) ASC");
    $stmt->execute();
    $num_ganancias_por_mes = $stmt->fetchAll(PDO::FETCH_ASSOC);
    if ($num_ganancias_por_mes != null) $num_ganancias_por_mes = array_column($num_ganancias_por_mes, 'total_ganancias');
    else $num_ganancias_por_mes = [];
    // num ventas por mes
    $stmt = $dbh->prepare("SELECT MONTH(fecha_publicacion) AS mes, count(id) AS num_ventas_mes FROM anuncios WHERE YEAR(fecha_publicacion) = YEAR(NOW()) AND vendido = 1 AND id_vendedor = $id_vendedor GROUP BY MONTH(fecha_publicacion) ORDER BY MONTH(fecha_publicacion) ASC");
    $stmt->execute();
    $num_ventas_por_mes = $stmt->fetchAll(PDO::FETCH_ASSOC);
    if ($num_ventas_por_mes != null) $num_ventas_por_mes = array_column($num_ventas_por_mes, 'num_ventas_mes');
    else $num_ventas_por_mes = [];
    // num media ventas plataforma por mes
    $mediaPlataforma = [15,2,3,4,10,5,8,12,5,5,4]; // Inventadas

    // Cargamos últimos 5 anuncios publicados
    $stmt = $dbh->prepare("SELECT id, nombre FROM anuncios WHERE id_vendedor = $id_vendedor ORDER BY fecha_publicacion DESC LIMIT 0, 5");
    $stmt->execute();
    $ultimosAnuncios = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Número de anuncios
    $stmt = $dbh->prepare("SELECT count(id) as num_anuncios FROM anuncios WHERE id_vendedor = $id_vendedor");
    $stmt->execute();
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    $num_anuncios = $result["num_anuncios"]; 
    if ($num_anuncios == null) $num_anuncios = 0;

    $dbh=close($dbh);


    require './home-vendedor.view.php';





