<?php

    // Si el método POST no indica la acción register, devolvemos json error
    if ($_POST["accion"] != "register" && $_POST["accion"] != "actualizar") { 
        header('Content-type: application/json');
        echo json_encode(["codError" => 400, "error" => "Bad request"]);
        die();
    }

    require '../bbdd.php';

    $codError = 0;
    $id_usuario = -1;
    $register = false;
    $foto = "default_user.png";

    $dbh = connect(true);
    $username = $_POST["username"];
    $descripcion = $_POST["descripcion"];
    $password = $_POST["password"];
    $email = $_POST["email"];

    // Parámetros control imagen
    $tipos_img_validos = ["jpg", "jpeg", "png", "gif", "jfif"];
    $size_maxima = 10485760; // <- 10 MB
    $nombre_guardar_img = null;
    $ruta_img = null;
    $imagen_guardada = false;

    // Recogemos la imagen
    if (isset($_FILES["img"]) && $codError == 0) {
        $img = $_FILES["img"];
        
        $ruta_img = "../../img/" . $_POST["nombre_carpeta"] . "/";
        $nombre_img = $img["name"];
        $tipo_archivo_img = strtolower(pathinfo($nombre_img, PATHINFO_EXTENSION));
        $nombre_guardar_img = $username . "-" . time() . "." . $tipo_archivo_img;

        // Comprobaciones errores, si encuentra un error deja de comprobar
        if ($_FILES["file"]["size"] > $size_maxima) // Tamaño máximo
            $codError = 1;
        else if(strpos("__" . $img["type"], "image") == false) // Tipo fichero
            $codError = 2;
        else if(!in_array($tipo_archivo_img, $tipos_img_validos)) // Tipo imagen
            $codError = 3;
        else if (!move_uploaded_file($_FILES["img"]["tmp_name"], $ruta_img . $nombre_guardar_img)) // Guardar la imagen
            $codError = 4;

        if ($codError == 0) $imagen_guardada = true;
    }

    // Si guardamos la imagen, almacenamos el nombre utilizado
    if ($imagen_guardada) {
        if ($nombre_guardar_img != null) {
            $foto = $nombre_guardar_img;
        }        
    }

    // Hasheamos la contraseña
    $password = hashPassword($password);

    if ($_POST["accion"] == "register") {
        // Comprobamos registro
        $data = array('username'=>$username, 'password'=>$password, 'email'=>$email, 'tipo'=>'C', 'foto'=>$foto);
        // Obtenemos el id del usuario recién registrado
        $id_usuario = registrarUsuario($dbh, $data);

        $dbh = close($dbh);

        if ($id_usuario != null && $id_usuario > 0) {
            $register = true; 
        } else {
            // Si ha guardado la imagen, pero no ha podido crear el usuario, borramos la imagen para evitar archivos residuales
            $codError = 5;
            unlink($ruta_img . $nombre_guardar_img);
        }

        // Preparamos la respuesta en formato JSON
        // Construimos el objeto JSON
        $result_json = array('register' => $register, 'id_usuario' => $id_usuario, 'codError' => $codError, 'foto' => $foto);
    } else {
        // Eliminamos la foto anterior si ha guardado una nueva
        if ($imagen_guardada) {
            eliminarFotoUsuario($dbh, ["username" => $username], true);
            setcookie("foto", $foto, time()+60*60*24*720);
        }
        else $foto = null;
        
        // Comprobamos update
        $data = array('username'=>$username, 'descripcion'=>$descripcion, 'password'=>$password, 'foto'=>$foto);
        
        // Guardamos los datos nuevos
        $exito = actualizarUsuario($dbh, $data);

        $dbh = close($dbh);

        if (!$exito) {
            // Si ha guardado la imagen, pero no ha podido crear el usuario, borramos la imagen para evitar archivos residuales
            $codError = 5;
            unlink($ruta_img . $nombre_guardar_img);
        }

        // Preparamos la respuesta en formato JSON
        // Construimos el objeto JSON
        $result_json = array('exito' => $exito, 'codError' => $codError, 'img_guardada' => $imagen_guardada, 'foto' => $foto);

    }
   
    // Definimos en los headers el tipo de contenido (que será JSON)
    header('Content-type: application/json');

    // Devolvemos el resultado
    echo json_encode($result_json);

    // Finalizamos el resto de la ejecución :)
    die();   
    
   
?>