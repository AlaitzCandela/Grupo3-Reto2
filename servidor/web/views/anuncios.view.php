<!DOCTYPE html>
<html lang="es">
<head>
    <?php
        require "./partials/metas.php";
    ?>
    <title>Descubrir anuncios</title>
    <link rel="stylesheet" href="../css/styleAnuncio.css">
</head>
<body>
    <div class="contenedor">
        <?php require "./partials/menu.php";?>
        <main>
            <?php
                $filtro_categorias = true;
                $profile_pic="../img/default_user.png";
                require "./partials/topbar.php";
            ?>
            
            <section>
                <div class="cuadricula" id="cuadricula-anuncios">
                </div>
            </section>
            <div id="boton">
                <button id="mas">M&aacute;s</button>
            </div>
           
        </main>
    </div>
    <?php require "./partials/scripts.php";?>
    <script src="../javaScript/anuncios.js"></script>
</body>
</html>

