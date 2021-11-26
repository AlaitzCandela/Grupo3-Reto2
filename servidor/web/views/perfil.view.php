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
                <?php if($datos_usuario["tipo"] == 'C'): ?>
                <div id="serVendedor">
                    <div class="contenido">
                    <?php require "./partials/modal.php"?>
                    </div>
                    <h3>Eres un usuario cliente</h3>
                    <p>Para convertirte en vendedor deber&aacute;s introducir algunos datos extra</p>
                    <button id="btnVendedor">Convertirme en vendedor</button>
                </div>
                <?php endif; ?>

                <div class="ajustes">
                    <form action="" method="post" id="form-perfil">
                        <label for="profile-pic-input"><img src="../img/usuarios/<?= $datos_usuario["foto"] ?>" alt="   " id="preview-profile-pic"></label>
                        <input <?= $disabled ? "disabled" : "" ?> type="file" name="imagen" id="profile-pic-input" accept="image/.jpg,.jpeg,.png,.gif,.jfif">

                        <?php if (!$disabled): ?>
                            <?php if ($datos_usuario["foto"] == null || $datos_usuario["foto"] == "default_user.png"): ?>
                                    <p id="btnBorrarImagen">Añadir imagen</p>
                                <?php else: ?>
                                    <p id="btnBorrarImagen">Borrar imagen</p>
                            <?php endif; ?>
                        <?php endif; ?>

                        <input disabled value="<?= $datos_usuario["username"] ?>" class="input" type="text" autocomplete="off" name="nombreUsuario" id="nombreUsuario" placeholder="Nombre de usuario">

                        <textarea <?= $disabled ? "disabled" : "" ?> class="input" autocomplete="off" name="descripcionUsuario" rows="2" id="descripcionUsuario" 
                        placeholder="<?= !$disabled ? "Sin descripción... ¡Añade algo!" : "Sin descripción" ?>"><?= $datos_usuario["descripcion"] ?></textarea>
                        
                        <?php if (!$disabled): ?>
                        <input required <?= $disabled ? "disabled" : "" ?> value="" type="password" name="password" id="password" placeholder="Contrase&ntilde;a">
                        <input required <?= $disabled ? "disabled" : "" ?> value="" type="password" name="password" id="reppassword" placeholder="Repetir contrase&ntilde;a">

                        <input type="submit" name="actualizarPerfil" id="enviarDatos" value="Actualizar perfil">
                        <?php endif; ?>
                    </form>
                </div>
            </section>
        </main>
    </div>
    <?php require "./partials/scripts.php";?>
    <script src="../javaScript/perfil.js"></script>
</body>
</html>