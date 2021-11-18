<!DOCTYPE html>
<html lang="es">
<head>
<?php
    require "./partials/metas.php";
?>
    <title>Plantilla bien perrona</title>
    <link rel="stylesheet" href="../css/styles.css">
    <link rel="stylesheet" href="../css/stylesUsuarios.css">
</head>
<body>
    <div class="contenedor">
        <?php require "./partials/menu.php";?>
        <main>
            <?php 
                $profile_pic="../img/default_user.png";
                require "./partials/topbar.php";
            ?>
            <div class="card-usuarios-wrapper">
                <div class="card-usuarios">
                    <table class="table-usuarios" cellspacing="0">
                        <thead>
                            <tr id="table-usuarios-encabezado">
                                <th>Usuario</th>
                                <th>Email</th>
                                <th>Tipo</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody id="usuarios-registrados">
                            <tr>
                                <td class="usuario-username clave" style="--wtd:15%">Ejemplo</td>
                                <td class="usuario-email" style="--wtd:40%">ejemplo@gmail.com</td>
                                <td class="usuario-tipo" style="--wtd:8%">Cliente</td>
                                <td class="usuario-acciones" style="--wtd:38%">
                                    <form action="usuarios.php"> <!-- Ver -->
                                        <input type="hidden" name="accion" value="ver">
                                        <button type="submit" class="btn btn-ver">
                                            <span class="icon"><ion-icon name="enter-outline"></ion-icon></span>
                                            <span class="title">Ver</span>
                                        </button>
                                    </form>
                                    <form action="usuarios.php"> <!-- Editar -->
                                        <input type="hidden" name="accion" value="editar">
                                        <button type="submit" class="btn btn-editar">
                                            <span class="icon"><ion-icon name="create-outline"></ion-icon></span>
                                            <span class="title">Editar</span>
                                        </button>
                                    </form>
                                    <form action="usuarios.php"> <!-- Eliminar -->
                                        <input type="hidden" name="accion" value="eliminar">
                                        <button type="submit" class="btn btn-eliminar">
                                            <span class="icon"><ion-icon name="close-circle-outline"></ion-icon></span>
                                            <span class="title">Eliminar</span>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>
    <?php require "./partials/scripts.php";?>
    
</body>
</html>