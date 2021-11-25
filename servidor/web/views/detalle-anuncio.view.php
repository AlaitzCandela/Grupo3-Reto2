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
                        <ion-icon id="anadirCarrito" name="<?= $carrito_icon_name?>" <?= $carrito_icon_class?> onclick='anadirCarrito(<?=$datos["id"]?>)'></ion-icon>
                    </div>
                    <hr id="separador2">
                    <p id="precio"> <?=$datos["precio"]?> &euro;</p>
                    <hr id="separador3">
                    <p id="datosContacto"> <span>Email: <?=$datos["email"]?> </span> <span>Tel&eacute;fono: <?=$datos["telefono"]?></span> <span>Direcci&oacute;n: <?=$datos["direccion"]?></span> </p>
                    <input type="hidden" id="id-anuncio" value="<?= $datos["id"] ?>">
                </div>
            </div>
        </main>
    </div>
    <?php require "./partials/scripts.php";?>
    <script src="../javaScript/anuncios.js"></script>
</body>
</html>