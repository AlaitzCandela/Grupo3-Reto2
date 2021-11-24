<!DOCTYPE html>
<html lang="es">
<head>
<?php
    require "./partials/metas.php";
?>
    <title>Anuncio</title>
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

            <div class="detalleAnuncio">
                <img src="../img/anuncios/<?=$datos["foto"]?>" alt="">

                <div class="informacion">
                    <h1 id="nombre"><?=$datos["nombre"]?></h1>
                    <hr id="separador1">
                    <h5 id="descripcion"><?=$datos["descripcion"]?></h5>
                    <ion-icon id="favoritos" name="<?= $fav_icon_name ?>" <?= $fav_icon_class ?> onclick='favoritos(<?=$datos["id"]?>)'></ion-icon>
                    <hr id="separador2">
                    <p id="precio"> <?=$datos["precio"]?> &euro;</p>
                </div>
            </div>
        </main>
    </div>
    <?php require "./partials/scripts.php";?>
    <script src="../javaScript/anuncios.js"></script>
</body>
</html>