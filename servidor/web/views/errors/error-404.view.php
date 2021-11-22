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
            <h2>ERROR 404: SERVIDOR NO ENCONTRADO </h2>
            <br/>
            <p>El servidor no pudo encontrar el contenido solicitado. Este código de respuesta es uno de los más famosos dada su alta ocurrencia en la web</p>
            <br/>
            <a href="javascript:history.back()">Volver</a>
            <!-- <a href="javascript:window.location.href=window.location.href">Reintentar</a> -->
        </div>
    </div>
    
        </main>
    </div>
    <?php require "../partials/scripts.php";?>
    
</body>
</html>





