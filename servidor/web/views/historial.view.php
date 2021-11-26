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
                    <?php if (count($anuncios) <= 0): ?>
                        <?php if ($tipo == 'C'): ?>
                            <div><span>Sin compras registradas</span></div>
                        <?php else: ?>
                            <div><span>Sin ventas registradas</span></div>
                        <?php endif; ?>
                    <?php else: ?>
                        <div><span>Nombre del producto</span><span>Enlace</span><span>Vendedor</span></div>
                        <?php foreach($anuncios as $anuncio): ?>
                            <div class="anuncioLista">
                                <span><?= $anuncio["nombre"] ?></span>
                                <span><a href="./detalle-anuncio.php?id=<?= $anuncio['id'] ?>">Ver el anuncio</a></span>
                                <span><a href="./home-vendedor.php?id=<?= $anuncio['id_vendedor'] ?>">Ver perfil vendedor</a></span>
                            </div>
                        <?php endforeach; ?>
                    <?php endif; ?>
                </div>

            </section>
        </main>
    </div>
    <?php require "./partials/scripts.php";?>
    <script>
        document.querySelectorAll('nav ul li').forEach((evt) => {
        evt.classList.remove('selected');
        document.querySelector('#menuHistorial').classList.add('selected');
    });
    </script>
</body>
</html>