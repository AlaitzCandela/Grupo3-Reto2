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
            <form action="" method="post">
                    <input type="text" name="nombre" id="nombre-anuncio" placeholder="Introduce&nbsp;el&nbsp;nombre&nbsp;de&nbsp;tu&nbsp;anuncio">
                    <textarea name="descripcion" rows="1" id="descripcion"  placeholder="Introduce&nbsp;una&nbsp;descripci&oacute;n&nbsp;para&nbsp;tu&nbsp;anuncio"></textarea>
                    <label for="img-input"><img src="#" alt="Sube&nbsp;la&nbsp;imagen&nbsp;de&nbsp;tu&nbsp;anuncio" id="preview"></label>
                    <input type="file" name="imagen" id="img-input" accept="image/*">
                </form>
            </div>
        </main>
    </div>
    <?php require "./partials/scripts.php";?>
    
</body>
</html>