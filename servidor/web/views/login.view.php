<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="../img/tomNookDinero.png" type="image/x-icon">
    <link rel="stylesheet" href="../css/login.css">
    <title>Entrar en Tom Nook</title>
</head>
<body>
    <div class="wrapper">
        <div class="card">
            <div class="registro">
                <p id="animacionRegistro" class="titulo"><span>Reg&iacute;strate</span></p>


                <form action="login.php" method="post" id="register">
                    <input type="text" name="username" placeholder="Nombre de usuario" required>
                    <input type="email" name="email" placeholder="Email" required>
                    <input type="password" name="password" placeholder="Contrase&ntilde;a" required>
                    <label for="profile-pic" class="penultimo">Foto de perfil</label>
                    <input type="file" name="imagen" accept="image/*" id="profile-pic">
                    <input type="submit" name="registro" value="Registrarse">
                    <input type="hidden" name="accion" value="register">
                </form>


            </div>
            <div class="inicio-sesion selected">
                <p id="animacionLogin" class="titulo"><span>Iniciar Sesi&oacute;n</span></p>


                <form action="home.php" method="post" id="login">
                    <input type="text" name="username" placeholder="Nombre de usuario" required>
                    <input type="password" class="penultimo" name="password" placeholder="Contrase&ntilde;a" required>
                    <input type="submit" name="login" value="Iniciar sesi&oacute;n">
                    <input type="hidden" name="accion" value="login">
                </form>


            </div>
        </div>
    </div>
    <script src="../javaScript/jquery-3.6.0.min.js"></script>
    <script src="../javaScript/login.js"></script>
    <script>
        
        // Submit del login
        $('#login').submit((e) => {
            e.preventDefault();

            let data = {
                username: $('#login input[name="username"]').val(),
                password: $('#login input[name="password"]').val(),
                accion: $('#login input[name="accion"]').val(),
            }

            $form = $(this);
            $.ajax({
                url: "./webservices/ws-login.php",
                type: "post",
                data:  data,
                error: function(error) {
                    // Error en la petición
                    alert("error");
                }
            })
            .then((respuesta) => {
                console.log(respuesta);
                if (respuesta.login) {
                    // Guardamos el id del usuario
                    document.cookie = "id_usuario=" + respuesta.id_usuario;
                    
                    // Usamos el sistema de rutas tope genial
                    window.location.href = './home.php';
                } else {
                    // Mostramos error por credenciales incorrectas
                    
                    // Vaciamos la contraseña para que la vuelva a introducir
                    $('#login input[name="password"]').val('');
                }
            })
            .catch((err) => {
                alert("error");
                $('#login input[name="password"]').val('');
            });

        });


        $('#register').submit((e) => {
            e.preventDefault();

            let data = {
                username: $('#register input[name="username"]').val(),
                password: $('#register input[name="password"]').val(),
                email:    $('#register input[name="email"]').val(),
                accion: $('#register input[name="accion"]').val(),
            }

            $form = $(this);
            $.ajax({
                url: "./webservices/ws-register.php",
                type: "post",
                data:  data,
                error: function(error) {
                    // Error en la petición
                    alert("error");
                }
            })
            .then((respuesta) => {
                console.log(respuesta);
                if (respuesta.register) {
                    if (respuesta.id_usuario > 0) { // Registrado con éxito
                        // Guardamos el id del usuario
                        document.cookie = "id_usuario=" + respuesta.id_usuario;

                        // Usamos el sistema de rutas tope genial
                        window.location.href = './home.php';
                    } else { // Error al registrar (ya existía)
                        // TODO: alert
                        $('#register input[name="password"]').val('');
                    }
                    
                } else {
                    // Error en la BBDD
                    $('#register input[name="password"]').val('');
                }
            })
            .catch((err) => {
                alert("error");
                $('#register input[name="password"]').val('');
            });

        });
       
     </script>
</body>
</html>