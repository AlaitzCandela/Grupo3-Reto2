<!DOCTYPE html>
<html lang="es">
<head>
<?php
    require "./partials/metas.php";
?>
    <title>Mi carrito</title>
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
            <div class="producto favorito">
                    <div class="imagenCarrito"><img src="../img/gatitoDurmiendo.jpeg" alt="foto"></div>
                    <div class="nombreProducto"><a href="#">Gatito</a></div>
                    <div class="precios">14.99&euro;</div>
                    <div class="acciones">
                        <div class="toggleFavorito"><ion-icon name="star-outline"></ion-icon></div>
                        <div class="eliminarProducto"><ion-icon name="close-outline"></ion-icon></div>
                    </div>
                </div>

                <div class="producto ">
                    <div class="imagenCarrito"><img src="../img/gatitoDurmiendo.jpeg" alt="foto"></div>
                    <div class="nombreProducto"><a href="#">Gatito</a></div>
                    <div class="precios">14.99&euro;</div>
                    <div class="acciones">
                        <div class="toggleFavorito"><ion-icon name="star-outline"></ion-icon></div>
                        <div class="eliminarProducto"><ion-icon name="close-outline"></ion-icon></div>
                    </div>
                </div>

                <div class="producto ">
                    <div class="imagenCarrito"><img src="../img/gatitoDurmiendo.jpeg" alt="foto"></div>
                    <div class="nombreProducto"><a href="#">Gatito</a></div>
                    <div class="precios">14.99&euro;</div>
                    <div class="acciones">
                        <div class="toggleFavorito"><ion-icon name="star-outline"></ion-icon></div>
                        <div class="eliminarProducto"><ion-icon name="close-outline"></ion-icon></div>
                    </div>
                </div>

                <div class="producto ">
                    <div class="imagenCarrito"><img src="../img/gatitoDurmiendo.jpeg" alt="foto"></div>
                    <div class="nombreProducto"><a href="#">Gatito</a></div>
                    <div class="precios">14.99&euro;</div>
                    <div class="acciones">
                        <div class="toggleFavorito"><ion-icon name="star-outline"></ion-icon></div>
                        <div class="eliminarProducto"><ion-icon name="close-outline"></ion-icon></div>
                    </div>
                </div>

                <div class="producto ">
                    <div class="imagenCarrito"><img src="../img/gatitoDurmiendo.jpeg" alt="foto"></div>
                    <div class="nombreProducto"><a href="#">Gatito</a></div>
                    <div class="precios">14.99&euro;</div>
                    <div class="acciones">
                        <div class="toggleFavorito"><ion-icon name="star-outline"></ion-icon></div>
                        <div class="eliminarProducto"><ion-icon name="close-outline"></ion-icon></div>
                    </div>
                </div>

                <div class="producto favorito">
                    <div class="imagenCarrito"><img src="../img/gatitoDurmiendo.jpeg" alt="foto"></div>
                    <div class="nombreProducto"><a href="#">Gatito</a></div>
                    <div class="precios">14.99&euro;</div>
                    <div class="acciones">
                        <div class="toggleFavorito"><ion-icon name="star-outline"></ion-icon></div>
                        <div class="eliminarProducto"><ion-icon name="close-outline"></ion-icon></div>
                    </div>
                </div>

                <div class="carritoOtros">
                    <span id="precioTotal">Precio Total: 89,94 &euro;</span>
                    <div class="controlesCarrito">
                        <button id="comprar-carrito">Comprar todo</button><button id="comprar-carrito">Vaciar Carrito</button>
                    </div>
                </div>
            </div>
        </main>
    </div>
    <?php require "./partials/scripts.php";?>
    <script src="../javaScript/carrito.js"></script>
</body>
</html>