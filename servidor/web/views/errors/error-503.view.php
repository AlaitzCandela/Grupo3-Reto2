<!DOCTYPE html>
<html lang="es">
<head>
<?php
    $nivel_view = 2;
    $ruta_dir = "";
    for($i = 0; $i < $nivel_view; $i++) {
        $ruta_dir .= "../";
    }
    require "../partials/metas.php";
?>
    <title>Plantilla bien perrona</title>
    <link rel="stylesheet" href="<?= $ruta_dir ?>css/styles.css">
    <link rel="stylesheet" href="<?= $ruta_dir ?>css/styleErrores.css">
</head>
<body>
    <div class="contenedor">
        <?php require "../partials/menu.php";?>
        <main>
            <?php 
                $profile_pic = $ruta_dir . "img/default_user.png";
                require "../partials/topbar.php";
            ?>
    <div class="error-img">
        <div class="img">
            <img src="../../img/tomNookSad.svg"/>
        </div>
        <div class="error">
            <h1>ERROR 503: SERVICIO NO ENCONTRADO </h1>
            <br/>
            <p>El servidor no está listo para manejar la petición. Causas comunes puede ser que el servidor está caído por mantenimiento o está sobrecargado. Hay que tomar en cuenta que junto con esta respuesta, una página usuario-amigable explicando el problema debe ser enviada. Estas respuestas deben 
            ser usadas para condiciones temporales y el encabezado HTTP Retry-After: debería, si es posible, contener el tiempo estimado antes de la recuperación del servicio.
            El webmaster debe también cuidar los encabezados relacionados al caché que son enviados junto a esta respuesta, ya que estas respuestas de condición temporal 
            deben usualmente no estar en el caché</p>
            <br/>
            <a href="javascript:history.back()">Volver</a>
            <!-- <a href="javascript:window.location.href=window.location.href">Reintentar</a> -->
        </div>
    </div>
    <p style="height: 60vh;"></p>
    
        </main>
    </div>
    <?php require "../partials/scripts.php";?>
    
</body>
</html>


