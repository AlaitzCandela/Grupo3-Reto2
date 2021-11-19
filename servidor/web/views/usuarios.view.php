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
            <div class="card-usuarios-wrapper">
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
                            <tr class="usuario-administrador">
                                <td class="usuario-username clave">Ejemplo</td>
                                <td class="usuario-email dn990">ejemplo@gmail.com</td>
                                <td class="usuario-tipo dn480">Cliente</td>
                                <td class="usuario-acciones">
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
                            <tr class="usuario-vendedor">
                                <td class="usuario-username clave">Ejemplo</td>
                                <td class="usuario-email dn990">ejemplo@gmail.com</td>
                                <td class="usuario-tipo dn480">Cliente</td>
                                <td class="usuario-acciones">
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
                            <tr class="usuario-cliente">
                                <td class="usuario-username clave">Ejemplo</td>
                                <td class="usuario-email dn990">ejemplo@gmail.com</td>
                                <td class="usuario-tipo dn480">Cliente</td>
                                <td class="usuario-acciones">
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
                <div class="botones-control">
                    <button class="btn btn-ver" id="cargar-mas-usuarios">Cargar más usuarios</button>
                    <button class="btn btn-ver display-none" id="anterior-pag-usuarios" disabled>Página anterior</button> <!-- Se habilita al pasar de página -->
                    <button class="btn btn-ver display-none" id="siguiente-pag-usuarios">Página siguiente</button>
                </div>
            </div>
    </div>
    <?php require "./partials/scripts.php";?>
    <script src="../javaScript/usuarios.js"></script>
</body>
</html>