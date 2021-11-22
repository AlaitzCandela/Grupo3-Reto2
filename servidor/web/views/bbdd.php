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
        $stmt = $dbh->prepare("INSERT INTO usuarios(username,password,email,tipo,foto) VALUES (:username,:password,:email,:tipo,:foto)");
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

    function obtenerFotoUsuario($dbh,$data) {
        $stmt = $dbh->prepare("SELECT foto FROM usuarios WHERE id = :id");
        $stmt->bindParam(':id', $data["id"], PDO::PARAM_INT);
        $stmt->execute();
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        return $result["foto"];
    }

    function cogerTipoUsuario($dbh,$data){
        $stmt = $dbh->prepare("SELECT tipo FROM usuarios WHERE id = :id");
        $stmt->bindParam(':id', $data["id"], PDO::PARAM_INT);
        $stmt->execute();
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        return $result["tipo"];
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
        $stmt = $dbh->prepare("INSERT INTO anuncios (fecha_caducidad,nombre,descripcion,precio,foto) VALUES (DATE_ADD(NOW(), INTERVAL :caducidad DAY), :nombre, :descripcion, :precio, :foto)");

        $stmt->bindParam(':caducidad', $data["tiempo_caducidad"], PDO::PARAM_INT);
        $stmt->bindParam(':nombre', $data["nombre"], PDO::PARAM_STR);
        $stmt->bindParam(':descripcion', $data["descripcion"], PDO::PARAM_STR);
        $stmt->bindParam(':precio', $data["precio"], PDO::PARAM_STR);
        $stmt->bindParam(':foto', $data["foto"], PDO::PARAM_STR);
        $stmt->execute();

        return $dbh->lastInsertId();
    }

    function insertarCategoriaAnuncios($dbh,$data){
        $stmt = $dbh -> prepare("INSERT INTO categoriasAnuncios VALUES (:id_anuncio,:id_categoria)");
        return $stmt->execute($data);
    }

    function cogerCategorias($dbh){
        $stmt = $dbh->prepare("SELECT * FROM categorias order by id");
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        return $result;
    }

    // Obtiene una serie de usuarios, con posibilidad de filtrar e indicar desde donde y cuántos usuarios coger
    function cogerUsuarios($dbh,$data) {
        $filtro = $data["filtro"];
        $inicio = $data["inicio"];
        $fin = $data["fin"];
        $stmt = $dbh->prepare("SELECT id,username,email,tipo,habilitado FROM usuarios LIMIT $inicio, $fin $filtro");
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        return $result;
    }

    // Deshabilita un usuario
    function deshabilitarUsuario($dbh,$data) {
        $stmt = $dbh->prepare("UPDATE usuarios SET habilitado = 0 WHERE id = :id");
        return $stmt->execute($data);
    }

    // Habilita un usuario
    function habilitarUsuario($dbh,$data) {
        $stmt = $dbh->prepare("UPDATE usuarios SET habilitado = 1 WHERE id = :id");
        return $stmt->execute($data);
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