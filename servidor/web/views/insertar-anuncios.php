<?php
    require "./bbdd.php";
    
    // Inicializamos la respuesta
    $respuesta_json = [
        "exito" => true // si los inserts han ido bien, devolverá true
    ];

    // Conectamos BBDD
    $dbh=connect();

    // Recogemos los datos del anuncio y lo insertamos
    $nombreProducto = $_POST["nombre"];
    $descripcion = $_POST["descripcion"];
    $foto = $_POST["foto"];
    $precio = doubleval($_POST["precio"]);
    $tiempo_caducidad = intval($_POST["caducidad"]);
    $data = array('nombre' => $nombreProducto, 'descripcion' => $descripcion, 'foto' => $foto, 'precio' => $precio, 'tiempo_caducidad' => $tiempo_caducidad);
    $id_anuncio = insertarAnuncios($dbh,$data);
    
    if ($id_anuncio >= 0) {
        // Recogemos las categorias, e insertamos en categoriasAnuncio
        $categorias = $_POST["categorias"];
        $categorias = explode(',', $categorias);
        foreach($categorias as $categoria) {
                $datos_categoriaAnuncios = array('id_anuncio'=>$id_anuncio,'id_categoria'=>$categoria);
                $exito = insertarCategoriaAnuncios($dbh,$datos_categoriaAnuncios);
                if (!$exito) { // Si da error al insertar alguna de las relaciones, salimos y devolvemos false
                    $respuesta_json["exito"] = false;
                    break;
                }
        }
        

    } else { // si no ha podido insertar el anuncio, devolvemos false
        $respuesta_json["exito"] = false;
    }

    // Cerramos conexión
    $dbh=close($dbh);

    // Devolvemos respuesta
    header('Content-type: application/json');
    echo json_encode($respuesta_json);
    die();   

?>