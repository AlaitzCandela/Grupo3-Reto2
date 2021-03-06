<?php

    // Si el método POST no indica la acción login, devolvemos json error
    if ($_POST["accion"] != "login") { 
        header('Content-type: application/json');
        echo json_encode(["codError" => 400, "error" => "Bad request"]);
        die();
    }

    require '../bbdd.php';

    $id_usuario = -1;
    $login = false;
    $foto = "default_user.png";

    $dbh = connect(true);
    $username = $_POST["username"];
    $password = $_POST["password"];

    // Comprobamos login
    $data = array('username'=>$username, 'password'=>$password);
    $id_usuario = comprobarCredencialesUsuario($dbh,$data);
    
    if ($id_usuario != null) {
        // Recogemos foto usuario
        $foto = obtenerFotoUsuario($dbh,array("id"=>$id_usuario));
        $login = true; 
    }
    
    $dbh = close($dbh);
    

    if ($foto == null || $foto == "undefined" || $foto == "") {
        $foto = "default_user.png";
    }

    // Preparamos la respuesta en formato JSON
    // Construimos el objeto JSON
    $result_json = array('login' => $login, 'id_usuario' => $id_usuario, 'foto' => $foto);

    // Definimos en los headers el tipo de contenido (que será JSON)
    header('Content-type: application/json');

    // Devolvemos el resultado
    echo json_encode($result_json);

    // Finalizamos el resto de la ejecución :)
    die();   
?>