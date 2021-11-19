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
        //$dbh->bindValue(0, 10, PDO::PARAM_INT);
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        return $result;
    }

    // Obtiene una serie de usuarios, con posibilidad de filtrar e indicar desde donde y cuántos usuarios coger
    function cogerUsuarios($dbh,$data) {
        //$filtro = $data["filtro"];
        $inicio = $data["inicio"];
        $fin = $data["fin"];
        $stmt = $dbh->prepare("SELECT id,username,email,tipo FROM usuarios LIMIT 0, 10");
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        return $result;
    }

    // Obtiene el número de usuarios registrados en total y lo devuelve
    function numeroUsuariosRegistrados($dbh) {
        $stmt = $dbh->prepare("SELECT count(*) as num_usuarios FROM usuarios");
        $stmt->execute();
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        return $result;
    }

    function close($dbh){
        $dbh = null;
        return $dbh;
    }

?>