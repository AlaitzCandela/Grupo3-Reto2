<?php
    require "../bbdd.php";
    
    // Conectamos BBDD
    $dbh=connect(true);

    // Inicializamos la respuesta
    $respuesta_json = [
        "exito" => true, // si los inserts han ido bien, devolverá true
        "codError" => 0
    ];

    // TODO dani: coger id asociado al token si reemplazamos el guardar directamente el id
    $id_vendedor = -1;
    if (isset($_COOKIE["id_usuario"])) {
        $id_vendedor = $_COOKIE["id_usuario"];
    } else {
        $respuesta_json["codError"] = 7;
    }

    // Parámetros control imagen
    $tipos_img_validos = ["jpg", "jpeg", "png", "gif", "jfif"];
    $size_maxima = 10485760; // <- 10 MB
    $nombre_guardar_img = null;
    $ruta_img = null;
    $imagen_guardada = false;

    // Recogemos la imagen
    if (isset($_FILES["img"]) && $respuesta_json["codError"] == 0) {
        $img = $_FILES["img"];
        
        $ruta_img = "../../img/" . $_POST["nombre_carpeta"] . "/";
        $nombre_img = $img["name"];
        $tipo_archivo_img = strtolower(pathinfo($nombre_img, PATHINFO_EXTENSION));
        $nombre_guardar_img = $id_vendedor . "-" . time() . "." . $tipo_archivo_img;

        // Comprobaciones errores, si encuentra un error deja de comprobar
        if ($_FILES["file"]["size"] > $size_maxima) // Tamaño máximo
            $respuesta_json["codError"] = 1;
        else if(strpos("__" . $img["type"], "image") == false) // Tipo fichero
            $respuesta_json["codError"] = 2;
        else if(!in_array($tipo_archivo_img, $tipos_img_validos)) // Tipo imagen
            $respuesta_json["codError"] = 3;
        else if (!move_uploaded_file($_FILES["img"]["tmp_name"], $ruta_img . $nombre_guardar_img)) // Guardar la imagen
            $respuesta_json["codError"] = 4;

        if ($respuesta_json["codError"] == 0) $imagen_guardada = true;
    }

    // Si no ha habido error, empezamos a insertar
    if ($respuesta_json["codError"] == 0) {

        // Recogemos los datos del anuncio y lo insertamos
        $nombreProducto = $_POST["nombre"];
        $descripcion = $_POST["descripcion"];
        if ($nombre_guardar_img == null) $foto = "default_anuncio.svg"; // <- si no ha seleccionado imagen
        else $foto = $nombre_guardar_img;
        $precio = doubleval($_POST["precio"]);
        $tiempo_caducidad = intval($_POST["caducidad"]);

        $data = array(
            'nombre' => $nombreProducto, 
            'descripcion' => $descripcion, 
            'foto' => $foto, 
            'precio' => $precio, 
            'tiempo_caducidad' => $tiempo_caducidad
        );
    
        $id_anuncio = insertarAnuncios($dbh,$data);

        if ($id_anuncio > 0) {
            // Recogemos las categorias, e insertamos en categoriasAnuncios
            $categorias = $_POST["categorias"];
            $categorias = explode(',', $categorias);
            foreach($categorias as $categoria) {
                    $datos_categoriaAnuncios = array('id_anuncio'=>$id_anuncio,'id_categoria'=>$categoria);
                    $exito = insertarCategoriaAnuncios($dbh,$datos_categoriaAnuncios);
                    if (!$exito) { // Si da error al insertar alguna de las relaciones, salimos y devolvemos false
                        $respuesta_json["exito"] = false;
                        $respuesta_json["codError"] = 6;
                        break;
                    }
            }
        } else { // Si no ha podido insertar el anuncio, devolvemos false
            $respuesta_json["codError"] = 5;
            $respuesta_json["exito"] = false;
        }

    } else {
        $respuesta_json["exito"] = false;
    }

    if (!$respuesta_json["exito"] && $imagen_guardada) {
        // Si la imagen se guardó pero no hemos podido guardar el anuncio, borramos la imagen
        unlink($ruta_img . $nombre_guardar_img);
        // TODO añadir al delete vendedor: array_map('unlink', glob($ruta_img . $id_vendedor . "*"));
    }

    // Cerramos conexión
    $dbh=close($dbh);

    // Devolvemos respuesta
    header('Content-type: application/json');
    echo json_encode($respuesta_json);
    die();   

?>