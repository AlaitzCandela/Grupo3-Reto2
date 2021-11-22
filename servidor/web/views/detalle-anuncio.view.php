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

            <div class="detalleAnuncio">
                <img src="https://via.placeholder.com/2500" alt="">

                <div class="informacion">
                    <h1 id="nombre">Nombre</h1>
                    <hr id="separador1">
                    <h5 id="descripcion">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Libero exercitationem eligendi, ut quisquam laboriosam architecto illo natus, neque repudiandae sint qui eos deleniti. Est saepe quisquam delectus illo pariatur doloribus?</h5>
                    <ion-icon id="favoritos" name="star-outline"></ion-icon>
                    <hr id="separador2">
                    <p id="precio">16.99 &euro;</p>
                </div>
            </div>
        </main>
    </div>
    <?php require "./partials/scripts.php";?>
    
</body>
</html>