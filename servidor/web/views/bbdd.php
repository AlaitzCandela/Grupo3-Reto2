<?php
    // Devuelve el gestor de la conexión a la BBDD (o lanza error y carga una vista / devuelve json error si es WS)
    function connect($webService=false){
        $host= 'localhost';
        $dbName = 'TN';
        $user = 'admin';
        $pass = 'admin';
        try {
            $dbh = new PDO("mysql:host=$host;dbname=$dbName;charset=utf8",$user,$pass);
            return $dbh;
        }
        catch (PDOException $e){
            if ($webService) {
                header('Content-type: application/json');
                echo json_encode(["error" => "Servidor no disponible", "codError" => 503]);
                die();
            }
            require "./error-503.php";
            die();
        }
    } 

    // Registra un nuevo usuario
    function registrarUsuario($dbh,$data){
        $stmt = $dbh->prepare("INSERT INTO usuarios(username,password,email,tipo,foto) VALUES (:username,:password,:email,:tipo,:foto)");
        $stmt->setFetchMode(PDO::FETCH_ASSOC);
        $stmt->execute($data);
        return $dbh->lastInsertId();
    }

    // Comprueba las credenciales del usuario, si existe y la contraseña es correcta, devuelve su id, si no, devuelve null
    function comprobarCredencialesUsuario($dbh,$data){
        $stmt = $dbh->prepare("SELECT id, password FROM usuarios WHERE UPPER(username) = UPPER(:username)");
        $stmt->bindParam(':username', $data["username"], PDO::PARAM_STR);
        $stmt->execute();
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        if ($result["id"] != null) { // Si el usuario existe, cotejamos contraseñas
            if (comprobarPassword($data["password"], $result["password"])) {
                return $result["id"];
            }
        }
        return null;
    }

    // Devuelve el string de la foto del usuario
    function obtenerFotoUsuario($dbh,$data) {
        $stmt = $dbh->prepare("SELECT foto FROM usuarios WHERE id = :id");
        $stmt->bindParam(':id', $data["id"], PDO::PARAM_INT);
        $stmt->execute();
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        return $result["foto"];
    }

    // Obtiene el tipo de usuario
    function cogerTipoUsuario($dbh,$data){
        $stmt = $dbh->prepare("SELECT tipo FROM usuarios WHERE id = :id");
        $stmt->bindParam(':id', $data["id"], PDO::PARAM_INT);
        $stmt->execute();
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        return $result["tipo"];
    }

    // Obtener los anuncios activos (no caducados) de más recientes a más antiguos
    function cogerAnuncios($dbh,$data){
        $inicio = $data["inicio"];
        $fin = $data["fin"];
        $stmt = $dbh->prepare("SELECT id,nombre,fecha_publicacion,foto,precio FROM anuncios WHERE vendido = 0 AND fecha_caducidad > NOW() ORDER BY fecha_publicacion DESC LIMIT $inicio, $fin");
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        return $result;
    }

    // Insertar un anuncio
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

    // Vincular un anuncio a una categoría
    function insertarCategoriaAnuncios($dbh,$data){
        $stmt = $dbh -> prepare("INSERT INTO categoriasAnuncios VALUES (:id_anuncio,:id_categoria)");
        return $stmt->execute($data);
    }

    // Obtener los datos de un anuncio en concreto
    function detalleAnuncio($dbh,$data){
        $stmt = $dbh->prepare(" SELECT a.id,a.nombre,a.descripcion,a.precio,a.foto,u.email,v.telefono,v.direccion FROM usuarios u,anuncios a,vendedores v  WHERE u.id = a.id_vendedor AND v.id = a.id_vendedor AND a.id = :id;");
        $stmt->bindParam(':id', $data["id"], PDO::PARAM_INT);
        $stmt->execute();
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        return $result;
    }

    // Devuelve un array asociativo con todas las categorías
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
        $stmt = $dbh->prepare("SELECT id,username,email,tipo,habilitado FROM usuarios $filtro LIMIT $inicio, $fin");
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        return $result;
    }

    // Obtiene los datos de un usuario buscando por ID y los devuelve
    function datosUsuario($dbh,$data) {
        $stmt = $dbh->prepare("SELECT id,username,email,tipo,habilitado,foto,descripcion FROM usuarios WHERE id = :id");
        $stmt->execute($data);
        $datos_usuario = $stmt->fetch(PDO::FETCH_ASSOC);
        return $datos_usuario;
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
    
    // Recibe un id de usuario, comprueba si existe y si está habilitado y devuelve un JSON con bool existe, bool habilitado y char tipo
    function usuarioLoggeado($dbh,$id_usuario) {
        $stmt = $dbh->prepare("SELECT tipo, habilitado FROM usuarios WHERE id = :id");
        $stmt->bindParam(':id', $id_usuario, PDO::PARAM_INT);
        $stmt->execute();
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        if ($result["tipo"] != null) {
            if ($result["habilitado"] == 1) {
                return ["existe" => true, "habilitado" => true, "tipo" => $result["tipo"]];
            } else {
                return ["existe" => true, "habilitado" => false, "tipo" => $result["tipo"]];
            }
        } else {
            return ["existe" => false, "habilitado" => false, "tipo" => ''];
        }
    }

    // Devuelve -1 si no existe, 0 si no está habilitado y 1 si está habilitado
    function obtenerHabilitadoUsuario($dbh,$id_usuario) {
        $stmt = $dbh->prepare("SELECT tipo, habilitado FROM usuarios WHERE id = :id");
        $stmt->bindParam(':id', $id_usuario, PDO::PARAM_INT);
        $stmt->execute();
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        if ($result["tipo"] == null) return -1; // <- si no, habilitado devolvería siempre 0, aunque no existiera resultado
        return $result["habilitado"];
    }

    // Comprueba si el usuario loggeado existe y sigue habilitado
    function usuarioLoggeadoYHabilitado() {
        $usuarioHabilitado = false;
        $habilitado = -1;

        if (isset($_COOKIE["id_usuario"])) {
            $dbh=connect();
            $habilitado = obtenerHabilitadoUsuario($dbh,$_COOKIE["id_usuario"]);
            if ($habilitado == 1) { 
                $usuarioHabilitado = true;
            }
            $dbh=close($dbh);
        }

        // Si no hay usuario loggeado o el usuario ha sido deshabilitado, redirigimos al login
        if (!$usuarioHabilitado) {
            // Forma limpia de borrar una cookie (server y browser)
            // https://stackoverflow.com/questions/686155/remove-a-cookie#:~:text=A%20clean%20way%20to%20delete%20a%20cookie
            limpiarCookiesUsuario();
            if ($habilitado == 0) setcookie("usuario-deshabilitado", "true", time() + 3600 * 24 * 7 * 4 * 12);
            header ("location: .\login.php");
            die();
        }

        return $habilitado;
    }

    // Elimina un usuario (y las imágenes vinculadas a él y sus anuncios para evitar archivos residuales)
    function eliminarUsuario($dbh,$data) {
        // Eliminar usuario
        $stmt = $dbh->prepare("DELETE FROM usuarios WHERE id = :id");
        $exito = $stmt->execute($data);
        if ($exito) { // Si elimina el usuario con éxito...
            // Eliminar fotos de anuncios del usuario (sus anuncios se eliminarán por ON DELETE CASCADE)
            array_map('unlink', glob("../img/anuncios/" . $data["id"] . "*"));
            
            // Eliminar foto personal del usuario
            $foto_usuario = obtenerFotoUsuario($dbh,$data);
            if ($foto_usuario != null && $foto_usuario != "default_user.png") unlink("../img/usuarios/". $foto_usuario);
        }
        return $exito;
    }

    // Cerrar conexión
    function close($dbh){
        $dbh = null;
        return $dbh;
    }


    /* ------------------------------------------------------------------------------ */
    // OTRAS FUNCIONES

    // Al cerrar sesión, limpiar las cookies relacionadas con usuario (se pierden cesta, favoritos, foto, id_usuario)
    function limpiarCookiesUsuario() {
        unset($_COOKIE["id_usuario"]);
        unset($_COOKIE["foto"]);
        unset($_COOKIE["cesta"]);
        unset($_COOKIE["favoritos"]);
        setcookie('id_usuario', '', 1);
        setcookie('foto', '', 1);
        setcookie('cesta', '', 1);
        setcookie('favoritos', '', 1);
    }

    // Recibe una contraseña y devuelve su hash (+ salt) para almacenarla en la BBDD
    function hashPassword($password) {
        // Info: https://www.php.net/manual/es/function.password-hash.php
        // Por defecto, el 'coste' del salt es 10, cuanto más 'coste' más seguridad pero también más recursos consume
        // PASSWORD_DEFAULT utiliza el algoritmo bcrypt 
        return password_hash($password, PASSWORD_DEFAULT, array('cost' => 8));
    }
    
    // Coteja una contraseña con su hash + salt, devuelve true si es correcta
    function comprobarPassword($password, $hashed_password) {
        // El valor del salt se guarda directamente con la password hasheada
        // https://i.stack.imgur.com/m8opZ.png
        return password_verify($password, $hashed_password);
    }

    // Pruebas hash
    /*
    $password1 = "1234";
    $password2 = "hola";
    $hash1 = hashPassword($password1);
    $hash2 = hashPassword($password2);

    echo "<h3>Contraseñas ==> Hashes</h3>";
    echo "<p>$password1 ==> $hash1</p>";
    echo "<p>$password2 ==> $hash2</p>";
    echo "<br>";
    echo "<h3>Verificar contraseña 1 con ambos hashes</h3>";
    echo "<p>$password1 con $hash1<br>". var_export(comprobarPassword($password1, $hash1)) ."</p><br>"; // true
    echo "<p>$password1 con $hash2<br>". var_export(comprobarPassword($password1, $hash2)) ."</p>"; // false
    echo "<br>";

    echo "<h3>Verificar contraseña 2 con ambos hashes</h3>";
    echo "<p>$password2 con $hash1<br>". var_export(comprobarPassword($password2, $hash1)) ."</p><br>"; // false
    echo "<p>$password2 con $hash2<br>". var_export(comprobarPassword($password2, $hash2)) ."</p>"; // true
    */

?>