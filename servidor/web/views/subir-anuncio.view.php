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
                    <label for="img-input"><img src="#" alt="Sube&nbsp;la&nbsp;imagen&nbsp;de&nbsp;tu&nbsp;anuncio" id="preview"></label>
                    <input type="file" name="imagen" id="img-input" accept="image/*">

                    <p id="btnBorrarImagen">Borrar imagen</p>

                    <input type="text" autocomplete="off" name="nombre" id="nombre-anuncio" required placeholder="Nombre">

                    <textarea name="descripcion" rows="2" id="descripcion" required placeholder="Descripci&oacute;n"></textarea>

                    <div class="contenedor-slider">
                        <input id="caducidad" name="caducidad" class="caducidad" type="range" name="caducidad" value="7" min="7" max="31"/>
                        <span id="valorCaducidad">7 D&iacute;as</span>
                    </div>

                    <input type="number" name="precio" id="precio" placeholder="Precio" required>
                    
                    <div class="categorias">
                        
                        <div>
                            <input type="checkbox" name="cat1" id="cat1" class="categoria-check">
                            <label for="cat1">Categor&iacute;a 1</label>
                        </div>

                        <div>
                            <input type="checkbox" name="cat2" id="cat2" class="categoria-check">
                            <label for="cat2">Categor&iacute;a 2</label>
                        </div>

                        <div>
                            <input type="checkbox" name="cat3" id="cat3" class="categoria-check">
                            <label for="cat3">Categor&iacute;a 3</label>
                        </div>

                        <div>
                            <input type="checkbox" name="cat4" id="cat4" class="categoria-check">
                            <label for="cat4">Categor&iacute;a 4</label>
                        </div>

                        <div>
                            <input type="checkbox" name="cat5" id="cat5" class="categoria-check">
                            <label for="cat5">Categor&iacute;a 5</label>
                        </div>

                        <div>
                            <input type="checkbox" name="cat5" id="cat6" class="categoria-check">
                            <label for="cat6">Categor&iacute;a 5</label>
                        </div>
                    </div>
                </form>
            </div>
        </main>
    </div>
    <?php require "./partials/scripts.php";?>
    
</body>
</html>