<?php
    function connect(){
        $host= 'localhost';
        $dbName = 'TN';
        $user = 'admin';
        $pass = 'admin';
        try {
            $dbh = new PDO("mysql:host=$host;dbname=$dbName",$user,$pass);
            return $dbh;
        }
        catch (PDOException $e){
            echo $e->getMessage();
            // TODO: reenviar a página de error
            die();
        }
    } 


    function registrarUsuario($dbh,$data){
        $stmt = $dbh->prepare("INSERT INTO usuarios(username,password,email,tipo) VALUES (:username,:password,:email,:tipo)");
        $stmt->setFetchMode(PDO::FETCH_ASSOC);
        $stmt->execute($data);
        return $dbh->lastInsertId();
    }

    function comprobarSiExisteUsuario($dbh,$data){
        $stmt = $dbh->prepare("SELECT id FROM usuarios WHERE UPPER(username) = UPPER(:username) AND password = :password");
        $stmt->execute($data);
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        return $result["id"];
    }

    function close($dbh){
        $dbh = null;
        return $dbh;
    }

?>