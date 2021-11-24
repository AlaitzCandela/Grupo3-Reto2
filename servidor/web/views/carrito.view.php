<!DOCTYPE html>
<html lang="es">
<head>
<?php
    require "./partials/metas.php";
?>
    <title>Plantilla bien perrona</title>
</head>
<body>
    <div class="contenedor">
        <?php require "./partials/menu.php";?>
        <main>
            <?php 
                $profile_pic="../img/default_user.png";
                require "./partials/topbar.php";
            ?>
            <div class="carrito">
                <div class="producto ">
                    <div class="imagenCarrito"><img src="../img/gatitoDurmiendo.jpeg" alt="foto"></div>
                    <div class="nombreProducto">Gatito super mega cute 4k real no fake 1 link mega</div>
                    <div class="acciones">
                        <div class="toggleFavorito"><ion-icon name="star-outline"></ion-icon></div>
                        <div class="eliminarProducto"><ion-icon name="close-outline"></ion-icon></div>
                    </div>
                </div>

                <div class="producto favorito">
                    <div class="imagenCarrito"><img src="../img/gatitoDurmiendo.jpeg" alt="foto"></div>
                    <div class="nombreProducto">Super cool</div>
                    <div class="acciones">
                        <div class="toggleFavorito"><ion-icon name="star-outline"></ion-icon></div>
                        <div class="eliminarProducto"><ion-icon name="close-outline"></ion-icon></div>
                    </div>
                </div>

                <div class="producto ">
                    <div class="imagenCarrito"><img src="../img/gatitoDurmiendo.jpeg" alt="foto"></div>
                    <div class="nombreProducto">Gatito</div>
                    <div class="acciones">
                        <div class="toggleFavorito"><ion-icon name="star-outline"></ion-icon></div>
                        <div class="eliminarProducto"><ion-icon name="close-outline"></ion-icon></div>
                    </div>
                </div>

                <div class="producto ">
                    <div class="imagenCarrito"><img src="../img/gatitoDurmiendo.jpeg" alt="foto"></div>
                    <div class="nombreProducto">Gatito</div>
                    <div class="acciones">
                        <div class="toggleFavorito"><ion-icon name="star-outline"></ion-icon></div>
                        <div class="eliminarProducto"><ion-icon name="close-outline"></ion-icon></div>
                    </div>
                </div>

                <div class="producto favorito">
                    <div class="imagenCarrito"><img src="../img/gatitoDurmiendo.jpeg" alt="foto"></div>
                    <div class="nombreProducto">Gatito</div>
                    <div class="acciones">
                        <div class="toggleFavorito"><ion-icon name="star-outline"></ion-icon></div>
                        <div class="eliminarProducto"><ion-icon name="close-outline"></ion-icon></div>
                    </div>
                </div>
            </div>
        </main>
    </div>
    <?php require "./partials/scripts.php";?>
    <script src="../javaScript/carrito.js"></script>
</body>
</html>