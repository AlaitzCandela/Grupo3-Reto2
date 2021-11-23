<!DOCTYPE html>
<html lang="es">
<head>
<?php
    require "./partials/metas.php";
?>
    <title>Plantilla bien perrona</title>
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
                <div class="estadisticas">
                    <div class="tarjeta"><p>Visitas: 234976</p><ion-icon name="eye-outline"></ion-icon></div>
                    <div class="tarjeta"><p>Beneficios: 1645€</p><ion-icon name="cash-outline"></ion-icon></div>
                    <div class="tarjeta"><p>Ventas: 162534</p><ion-icon name="bag-handle-outline"></ion-icon></div>
                </div>

                <div titulo="PEDIDOS" class="pedidos">
                    <div><span>Nombre del producto</span><span>Cliente</span><span>Precio</span></div>
                    <div><span>Producto de prueba</span><span>Cliente de prueba</span><span>00.00 &euro;</span></div>
                    <div><span>Producto de prueba</span><span>Cliente de prueba</span><span>00.00 &euro;</span></div>
                    <div><span>Producto de prueba</span><span>Cliente de prueba</span><span>00.00 &euro;</span></div>
                    <div><span>Producto de prueba</span><span>Cliente de prueba</span><span>00.00 &euro;</span></div>
                </div>

                <div class="grafico circular"><canvas id="graficoCircular"></canvas></div>
                <div class="grafico lineas"><canvas id="graficoLineas"></canvas></div>
            </section>
        </main>
    </div>
    <?php require "./partials/scripts.php";?>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.6.0/dist/chart.min.js"></script>
    <script src="../javaScript/graficos.js"></script>
</body>
</html>