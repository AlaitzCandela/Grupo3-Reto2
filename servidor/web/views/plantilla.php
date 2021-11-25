<?php // Comprobamos que no ha cargado a mano la URL de la vista
    require "./partials/controlado.php";
?>
<!DOCTYPE html>
<html lang="es">
<head>
<?php
    $nivel_view = 1;
    $ruta_dir = "";
    for($i = 0; $i < $nivel_view; $i++) {
        $ruta_dir .= "../";
    }
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
                require "./partials/topbar.php";
            ?>
        </main>
    </div>
    <?php require "./partials/scripts.php";?>
    
</body>
</html>