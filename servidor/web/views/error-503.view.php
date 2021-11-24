<!DOCTYPE html>
<html lang="es">
<head>
<?php
    require "./partials/metas.php";
?>
    <title>Error 503</title>
    <link rel="stylesheet" href="../css/styleErrores.css">
</head>
<body>
    <div class="contenedor">
        <?php require "./partials/menu.php";?>
        <main>
            <?php 
                $profile_pic = "../img/default_user.png";
                require "./partials/topbar.php";
            ?>
    <div class="error-img">
        <div class="img">
            <img src="../img/tomNookSad.svg"/>
        </div>
        <div class="error">
            <h1>ERROR 503: SERVICIO NO ENCONTRADO </h1>
            <br/>
            <p>El servidor no está listo para manejar la petición. Causas comunes puede ser que el servidor está caído por mantenimiento o está sobrecargado. </p>
            <br/>
            <a href="javascript:history.back()">Volver</a>
            <!-- <a href="javascript:window.location.href=window.location.href">Reintentar</a> -->
        </div>
    </div>
    <p style="height: 60vh;"></p>
    
        </main>
    </div>
    <?php require "./partials/scripts.php";?>
    
</body>
</html>


