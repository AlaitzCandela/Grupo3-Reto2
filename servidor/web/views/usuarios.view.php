<!DOCTYPE html>
<html lang="es">
<head>
<?php
    require "./partials/metas.php";
?>
    <title>Gestión Usuarios</title>
    <link rel="stylesheet" href="../css/styles.css">
    <link rel="stylesheet" href="../css/stylesUsuarios.css">
    <link rel="stylesheet" href="../css/sweetalert2.min.css">
</head>
<body>
    <div class="contenedor">
        <div class="card-usuarios-wrapper">
            <div class="leyenda">
                <p class="leyenda-titulo">Leyenda: </p>
                <p class="leyenda-cliente">Cliente</p>
                <p class="leyenda-vendedor">Vendedor</p>
                <p class="leyenda-admin">Administrador</p>
            </div>
            <div class="card-usuarios">
                <table class="table-usuarios" cellspacing="0"> <!-- cellspacing="0" -->
                    <thead>
                        <tr id="table-usuarios-encabezado">
                            <th class="th-usuario">Usuario</th>
                            <th class="th-email dn990">Email</th>
                            <th class="th-tipo dn480">Tipo</th>
                            <th class="th-acciones">Acciones</th>
                        </tr>
                    </thead>
                    <tbody id="usuarios-registrados">

                    </tbody>
                </table>
            </div>
            <div class="botones-control">
                <button class="btn btn-ver" id="cargar-mas-usuarios">Cargar más usuarios</button>
                <button class="btn btn-ver display-none" id="anterior-pag-usuarios" disabled>Página anterior</button> <!-- Se habilita al pasar de página -->
                <button class="btn btn-ver display-none" id="siguiente-pag-usuarios">Página siguiente</button>
            </div>
        </div>
    </div>
    <?php 
        $no_appjs = true;
        require "./partials/scripts.php";
    ?>
    <script src="../javaScript/sweetalert2.min.js"></script>
    <script src="../javaScript/usuarios.js"></script>
</body>
</html>