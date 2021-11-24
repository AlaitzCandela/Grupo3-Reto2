<!DOCTYPE html>
<html lang="es">
<head>
<?php
    require "./partials/metas.php";
?>
    <title>Anuncio</title>
</head>
<body>
    <div class="contenedor">
        <?php require "./partials/menu.php";?>
        <main>
            <?php 
                $profile_pic="../img/default_user.png";
                require "./partials/topbar.php";
            ?>

            <div class="detalleAnuncio">
                <img src="../img/anuncios/<?=$datos["foto"]?>" alt="">

                <div class="informacion">
                    <h1 id="nombre"><?=$datos["nombre"]?></h1>
                    <hr id="separador1">
                    <h5 id="descripcion"><?=$datos["descripcion"]?></h5>
                    <div class="accionesAnuncio">
                        <ion-icon id="favoritos" name="<?= $fav_icon_name ?>" <?= $fav_icon_class ?> onclick='favoritos(<?=$datos["id"]?>)'></ion-icon>
                        <ion-icon id="anadirCarrito" name="bag-add-outline"></ion-icon>
                    </div>
                    <hr id="separador2">
                    <p id="precio"> <?=$datos["precio"]?> &euro;</p>
                    <hr id="separador3">
                    <p id="datosContacto"> <span>Email: placeholder@gmail.com</span> <span>Tel&eacute;fono: 123456789</span> <span>Direcci&oacute;n: C/placeholder Nº00</span> </p>
                </div>
            </div>
        </main>
    </div>
    <?php require "./partials/scripts.php";?>
    <script src="../javaScript/anuncios.js"></script>
</body>
</html>