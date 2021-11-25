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
            <div class="carrito" id="carrito-productos">
                <?php if (count($productos_carrito) <= 0): ?>
                    <div class="producto">
                        <div class="nombreProducto"><a href="./anuncios.php">Sin productos en la cesta.</a></div>
                    </div>
                <?php endif; ?>
                <?php foreach($productos_carrito as $producto): ?>
                    <div class="producto" id="carrito-producto-<?= $producto['id'] ?>">
                        <div class="imagenCarrito"><img src="../img/anuncios/<?=$producto['foto']?>" alt="foto"></div>
                        <div class="nombreProducto"><a href="./detalle-anuncio.php?id=<?= $producto['id'] ?>"><?=$producto['nombre']?></a></div>
                        <div class="precios"><?=$producto['precio']?></div>
                        <div class="acciones">
                            <?php if (in_array($producto["id"], explode(",",$_COOKIE["favoritos"]))): ?>
                                <div class="toggleFavorito"><ion-icon onclick="clickFavoritos(<?= $producto['id'] ?>)" name="star"></ion-icon></div>
                            <?php else: ?>
                                <div class="toggleFavorito"><ion-icon onclick="clickFavoritos(<?= $producto['id'] ?>)" name="star-outline"></ion-icon></div>
                            <?php endif; ?>
                            <div class="eliminarProducto" onclick="eliminarDeCesta(<?= $producto['id'] ?>, <?= $producto['precio'] ?>)"><ion-icon name="close-outline"></ion-icon></div>
                        </div>
                    </div>
                <?php endforeach; ?>

                <div class="carritoOtros">
                    <span id="precioTotal">Total: <span id="precioTotalValor"><?= $precio_total ?></span>&euro;</span>
                    <div class="controlesCarrito">
                        <button id="comprar-carrito" onclick="comprarCarrito()">Comprar todo</button><button id="vaciar-carrito" onclick="vaciarCarrito()">Vaciar Carrito</button>
                    </div>
                </div>
            </div>
        </main>
    </div>
    <?php require "./partials/scripts.php";?>
    <script src="../javaScript/carrito.js"></script>
</body>
</html>