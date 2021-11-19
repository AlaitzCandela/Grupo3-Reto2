<!DOCTYPE html>
<html lang="es">
<head>
<?php
    require "./partials/metas.php";
?>
    <title>Plantilla bien perrona</title>
    
</head>
<body>
    <div class="contenedor">
       
        <main>
           
            <form action="./insertar-anuncios.php" method="post">
                <label for="" >Nombre</label>
                <input type="text" name="nombre" id=""/>
                <label for="">descripcion</label>
                <input type="text-area" name="descripcion" id=""/>
                <label for="">foto</label>
                <input type="file" name="foto" id=""/>
                <label for="">precio</label>
                <input type="number" name="precio" id=""/>
                <label for="">categoria</label>
                <input type="number" name="categoria" id=""/>
                <label for="">caducidad</label>
                <input type="number" name="caducidad" id=""/>
                <input type="submit" value="Enviar"/>
            </form>
        </main>
    </div>
    <?php require "./partials/scripts.php";?>
    
</body>
</html>