<?php
    
    require '../bbdd.php';

    $id_usuario = -1;
    $login = false;

    if ($_POST["accion"] == "login") {
        $dbh = connect();
        $username = $_POST["username"];
        $password = $_POST["password"];
    
        // Comprobamos login
        $data = array('username'=>$username, 'password'=>$password);
        $id_usuario = comprobarSiExisteUsuario($dbh,$data);
        $dbh = close($dbh);
    
        if ($id_usuario != null) {
            $login = true; 
        }
    }


    // Preparamos la respuesta en formato JSON
    // Construimos el objeto JSON
    $result_json = array('login' => $login, 'id_usuario' => $id_usuario);

    // Definimos en los headers el tipo de contenido (que será JSON)
    header('Content-type: application/json');

    // Devolvemos el resultado
    echo json_encode($result_json);

    // Finalizamos el resto de la ejecución :)
    die();   
?>