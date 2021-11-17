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
            <table>
                <thead>
                    <tr>
                        <th>Usuario</th>
                        <th>Email</th>
                        <th>Tipo</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody id="usuarios-registrados">
                    <tr>
                        <td>Ejemplo</td>
                        <td>ejemplo@gmail.com</td>
                        <td>Cliente</td>
                        <td>
                            <form action="usuarios.php"> <!-- Ver -->
                                <input type="hidden" name="accion" value="ver">
                                <button type="submit" class="btn-ver">
                                    <span class="icon"><ion-icon name="enter-outline"></ion-icon></span>
                                    <span class="title">Ver</span>
                                </button>
                            </form>
                            <form action="usuarios.php"> <!-- Editar -->
                                <input type="hidden" name="accion" value="editar">
                                <button type="submit" class="btn-editar">
                                    <span class="icon"><ion-icon name="create-outline"></ion-icon></span>
                                    <span class="title">Editar</span>
                                </button>
                            </form>
                            <form action="usuarios.php"> <!-- Eliminar -->
                                <input type="hidden" name="accion" value="eliminar">
                                <button type="submit" class="btn-eliminar">
                                    <span class="icon"><ion-icon name="close-circle-outline"></ion-icon></span>
                                    <span class="title">Eliminar</span>
                                </button>
                            </form>
                        </td>
                    </tr>
                </tbody>
            </table>
        </main>
    </div>
    <?php require "./partials/scripts.php";?>
    
</body>
</html>