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
            <input type="hidden" id="id-vendedor" value="<?= $_GET["id"] ?>">
            <input type="hidden" id="valores-ganancias-mes" value="<?= implode(',', $num_ganancias_por_mes) ?>">
            <input type="hidden" id="valores-ventas-mes" value="<?= implode(',', $num_ventas_por_mes) ?>">
            <input type="hidden" id="valores-ventas-media" value="<?= implode(',', $mediaPlataforma) ?>">
            <section>
                <div class="estadisticas">
                    <div class="tarjeta"><p>Visitas: <?= $num_visitas_totales ?></p><ion-icon name="eye-outline"></ion-icon></div>
                    <div class="tarjeta"><p>Beneficios: <?= number_format($ganancias_totales, 2) ?>€</p><ion-icon name="cash-outline"></ion-icon></div>
                    <div class="tarjeta"><p>Ventas: <?= $num_ventas_totales ?></p><ion-icon name="bag-handle-outline"></ion-icon></div>
                </div>

                <div id="misAnuncios" titulo="MIS ANUNCIOS" class="pedidos">
                    <?php if (count($ultimosAnuncios) <= 0): ?>
                        <div><span>Sin anuncios publicados</span></div>
                    <?php else: ?>
                        <div><span>Nombre del producto</span><span>Enlace</span><span>Acci&oacute;n</span></div>
                        <?php foreach($ultimosAnuncios as $anuncio): ?>
                            <div class="anuncioLista">
                                <span><?= $anuncio["nombre"] ?></span>
                                <span><a href="./detalle-anuncio.php?id=<?= $anuncio['id'] ?>"><?= $privilegios_borrar ? "Ver mi anuncio" : "Ver el anuncio" ?></a></span>
                                <?php if ($privilegios_borrar): ?>
                                    <span onclick="eliminarAnuncio(event, <?= $anuncio['id'] ?>)">
                                        <span id="span-nieto">Borrar</span>
                                    </span>
                                <?php else: ?>
                                    <span class="spdisabled" disabled>
                                        <span disabled id="span-nieto">Borrar</span>
                                    </span>
                                <?php endif; ?>
                            </div>
                        <?php endforeach; ?>
                        <?php if ($num_anuncios > 5): ?>
                            <div id="verTodo">Ver todos los anuncios</div>
                        <?php endif; ?>
                    <?php endif; ?>
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