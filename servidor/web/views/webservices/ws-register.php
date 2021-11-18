<?php
    
    require '../bbdd.php';

    $id_usuario = -1;
    $register = false;

    if ($_POST["accion"] == "register") {
        $dbh = connect();
        $username = $_POST["username"];
        $password = $_POST["password"];
        $email = $_POST["email"];
    
        // Comprobamos registro
        $data = array('username'=>$username, 'password'=>$password, 'email'=>$email, 'tipo'=>'C');
        // Obtenemos el id del usuario recién registrado
        $id_usuario = registrarUsuario($dbh, $data);

        $dbh = close($dbh);
    
        if ($id_usuario != null) {
            $register = true; 
        }
    }


    // Preparamos la respuesta en formato JSON
    // Construimos el objeto JSON
    $result_json = array('register' => $register, 'id_usuario' => $id_usuario);

    // Definimos en los headers el tipo de contenido (que será JSON)
    header('Content-type: application/json');

    // Devolvemos el resultado
    echo json_encode($result_json);

    // Finalizamos el resto de la ejecución :)
    die();   
?>