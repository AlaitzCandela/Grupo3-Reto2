<?php
    function connect(){
        $host= 'localhost';
        $dbName = 'TN';
        $user = 'admin';
        $pass = 'admin';
        try {
            $dbh = new PDO("mysql:host=$host;dbname=$dbName;charset=utf8",$user,$pass);
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

    function cogerAnuncios($dbh,$data){
        $inicio = $data["inicio"];
        $fin = $data["fin"];
        $stmt = $dbh->prepare("SELECT id,nombre,fecha_publicacion,foto,precio FROM anuncios WHERE vendido = 0 LIMIT $inicio, $fin");
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        return $result;
    }

    function insertarAnuncios($dbh,$data){
        $stmt = $dbh->prepare("INSERT INTO anuncios (fecha_caducidad,nombre,descripcion,precio) VALUES (DATE_ADD(NOW(), INTERVAL :caducidad DAY), :nombre, :descripcion, :precio)");

        $stmt->bindParam(':caducidad', $data["tiempo_caducidad"], PDO::PARAM_INT);
        $stmt->bindParam(':nombre', $data["nombre"], PDO::PARAM_STR);
        $stmt->bindParam(':descripcion', $data["descripcion"], PDO::PARAM_STR);
        $stmt->bindParam(':precio', $data["precio"], PDO::PARAM_STR);
        $stmt->execute();

        return $dbh->lastInsertId();
    }

    function insertarCategoriaAnuncios($dbh,$data){
        $stmt = $dbh -> prepare("INSERT INTO categoriasAnuncios VALUES (:id_anuncio,:id_categoria)");
        $stmt->execute($data);
    }

    function close($dbh){
        $dbh = null;
        return $dbh;
    }

?>