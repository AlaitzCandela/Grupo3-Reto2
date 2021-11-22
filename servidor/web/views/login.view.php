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
                    <input type="password" name="repetir-password" placeholder="Repite la contrase&ntilde;a" required>
                    <label for="profile-pic" class="penultimo">Foto de perfil</label>
                    <input type="file" name="imagen" accept="image/.jpg,.jpeg,.png,.gif,.jfif" id="profile-pic">
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
</body>
</html>