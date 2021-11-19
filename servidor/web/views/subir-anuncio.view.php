<!DOCTYPE html>
<html lang="es">
<head>
<?php
    require "./partials/metas.php";
?>
    <title>Sube tu anuncio</title>
    <link rel="stylesheet" href="../css/styles.css">
</head>
<body>
    <div class="contenedor">
        <?php require "./partials/menu.php";?>
        <main>
            <?php 
                $profile_pic="../img/default_user.png";
                require "./partials/topbar.php";
            ?>

            <div class="contenedor-formulario">
            <form action="insertar-anuncios.php" method="post">
                    <label for="img-input"><img src="#" alt="   " id="preview"><svg xmlns="http://www.w3.org/2000/svg" id="placeholder-img" viewBox="0 0 512 512"><title>Cloud Upload</title><path d="M320 367.79h76c55 0 100-29.21 100-83.6s-53-81.47-96-83.6c-8.89-85.06-71-136.8-144-136.8-69 0-113.44 45.79-128 91.2-60 5.7-112 43.88-112 106.4s54 106.4 120 106.4h56" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="32"/><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="32" d="M320 255.79l-64-64-64 64M256 448.21V207.79"/></svg><span id="placeholder">Subir imagen</span></label>
                    <input type="file" name="imagen" id="img-input" accept="image/*">

                    <p id="btnBorrarImagen">Borrar imagen</p>

                    <input class="input" type="text" autocomplete="off" name="nombre" id="nombre-anuncio" required placeholder="Nombre">

                    <textarea class="input" autocomplete="off" name="descripcion" rows="2" id="descripcion" required placeholder="Descripci&oacute;n"></textarea>

                    <div class="contenedor-slider">
                        <input id="caducidad" name="caducidad" class="caducidad" type="range" name="caducidad" value="7" min="7" max="31"/>
                        <span id="valorCaducidad">7 D&iacute;as</span>
                    </div>

                    <input class="input" autocomplete="off" type="number" step="0.01" name="precio" id="precio" placeholder="Precio" required>
                    
                    <div class="categorias">
                    </div>
                    <input type="submit" id="enviarDatos" value="Publicar anuncio">
                </form>
            </div>
        </main>
    </div>
    <?php require "./partials/scripts.php";?>
    <script src="../javaScript/insertar-anuncio.js"></script>
</body>
</html>