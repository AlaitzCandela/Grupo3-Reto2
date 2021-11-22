<!DOCTYPE html>
<html lang="es">
<head>
<?php
    require "./partials/metas.php";
?>
    <title>Plantilla bien perrona</title>
    <link rel="stylesheet" href="../css/styles.css">
    <link rel="stylesheet" href="../css/styleErrores.css">
</head>
<body>
    <div class="contenedor">
        <?php require "./partials/menu.php";?>
        <main>
            <?php 
                $profile_pic="../img/usuarios/default_user.png";
                require "./partials/topbar.php";
            ?>
    <div class="error-img">
        
    <div class="img">
            <img src="../img/tomNookSad.svg"/>
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
    <?php require "./partials/scripts.php";?>
    
</body>
</html>





