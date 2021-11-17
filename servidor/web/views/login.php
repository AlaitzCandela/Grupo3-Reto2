<?php
    
    require './bbdd.php';

    if (isset($_POST["accion"])) {
        $accion = $_POST["accion"];
        
        $username = $_POST["username"];
        $password = $_POST["password"];
        
        switch($accion){
            
            case 'register': 
                $email = $_POST["email"];
                registrar($username,$password,$email);
                break;
            case 'login': iniciarSesion($username,$password);
                break;
        }
    }
   

    function registrar($username,$password,$email){
        $dbh = connect();
        $data = array('username'=>$username,'password'=>$password,'email'=>$email,'tipo'=>'C');
        registrarUsuario($dbh,$data);
        $dbh = close($dbh);
    }

    function iniciarSesion($username,$password){
        $dbh = connect();
        $data = array('username'=>$username,'password'=>$password);
        $id_usuario=comprobarSiExisteUsuario($dbh,$data);
        if($id_usuario == null){
            echo "no existe";
            require 'login.views.php';   
        }
        else{
            echo "bieeeen";
            require 'login.views.php';   //Lo pongo separado para que pueda cojer el id de usuario desde javascript para hacer un localStorage
        }
    }

   
?>