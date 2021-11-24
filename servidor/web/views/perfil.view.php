<!DOCTYPE html>
<html lang="es">
<head>
<?php
    require "./partials/metas.php";
?>
    <title>Mi perfil</title>
</head>
<body>
    <div class="contenedor">
        <?php require "./partials/menu.php";?>
        <main>
            <?php 
                $profile_pic="../img/default_user.png";
                require "./partials/topbar.php";
            ?>
            <section>
                <div id="serVendedor">
                    <div class="contenido">
                    <?php require "./partials/modal.php"?>
                    </div>
                    <h3>Eres un usuario cliente</h3>
                    <p>Para convertirte en vendedor deber&aacute;s introducir algunos datos extra</p>
                    <button id="btnVendedor">Convertirme en vendedor</button>
                </div>

                <div class="ajustes">
                    <form action="" method="post" id="form-perfil">
                        <label for="profile-pic-input"><img src="../img/usuarios/default_user.png" alt="   " id="preview-profile-pic"></label>
                        <input type="file" name="imagen" id="profile-pic-input" accept="image/.jpg,.jpeg,.png,.gif,.jfif">

                        <p id="btnBorrarImagen">Borrar imagen</p>

                        <input class="input" type="text" autocomplete="off" name="nombreUsuario" id="nombreUsuario" placeholder="Nombre de usuario">

                        <textarea class="input" autocomplete="off" name="descripcionUsuario" rows="2" id="descripcionUsuario" placeholder="Descripci&oacute;n"></textarea>

                        <input type="password" name="password" id="password" placeholder="Nueva contrase&ntilde;a">
                        <input type="password" name="password" id="reppassword" placeholder="Repetir contrase&ntilde;a">

                        <input type="submit" name="actualizarPerfil" id="enviarDatos" value="Actualizar perfil">
                    </form>
                </div>
            </section>
        </main>
    </div>
    <?php require "./partials/scripts.php";?>
    <script src="../javaScript/perfil.js"></script>
</body>
</html>