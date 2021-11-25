<!DOCTYPE html>
<html lang="es">
<head>
<?php
    require "./partials/metas.php";
?>
    <title>Home</title>
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

                <div titulo="HISTORIAL" class="pedidos" id="historial">
                    <div><span>Nombre del producto</span><span>Enlace</span><span>Fecha</span></div>
                    <div class="anuncioLista"><span>Producto de prueba</span><span><a href="#">Ver el anuncio</a></span><span>dd/MM/yyyy</></div>
                    <div class="anuncioLista"><span>Producto de prueba</span><span><a href="#">Ver el anuncio</a></span><span>dd/MM/yyyy</></div>
                    <div class="anuncioLista"><span>Producto de prueba</span><span><a href="#">Ver el anuncio</a></span><span>dd/MM/yyyy</></div>
                    <div class="anuncioLista"><span>Producto de prueba</span><span><a href="#">Ver el anuncio</a></span><span>dd/MM/yyyy</></div>
                    <div class="anuncioLista"><span>Producto de prueba</span><span><a href="#">Ver el anuncio</a></span><span>dd/MM/yyyy</></div>
                </div>

            </section>
        </main>
    </div>
    <?php require "./partials/scripts.php";?>
    <script src="../javaScript/historial.js"></script>
</body>
</html>