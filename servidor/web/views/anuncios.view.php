<!DOCTYPE html>
<html lang="es">
<head>
    <?php
        require "./partials/metas.php";
    ?>
    <title>Descubrir anuncios</title>
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
            
            <section>
                <div class="cuadricula" id="cuadricula-anuncios">
                </div>
            </section>
            <button id="mas">M&aacute;s</button>

        </main>
    </div>
    <?php require "./partials/scripts.php";?>
    <script src="../javaScript/anuncios.js"></script>
</body>
</html>

