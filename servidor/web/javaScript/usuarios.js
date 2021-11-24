var paginaActual = 1;
var paginaTope;
var numeroTotalUsuarios;
var numVecesCargar = 5; // Cuantas veces hay que cargar antes de pasar página
var numeroElementos = 10; // Elementos a cargar cada vez
var numVecesCargado = 0; // Número de veces cargado
var filtro = false;

$(document).ready(() => {
    // Petición que primero obtiene número total de usuarios y luego los obtiene
    cargarNumeroMaximoUsuarios();

    // Preparamos los listeners
    $("#cargar-mas-usuarios").on('click', mostrarMasUsuarios);
    $("#anterior-pag-usuarios").on('click', anteriorPagUsuarios);
    $("#siguiente-pag-usuarios").on('click', siguientePagUsuarios);
    $("#search").on('click', mostrarInputBusqueda);
    $("#search").on('change', filtrarUsuarios);
    $("#search").keydown(keydownFiltrarUsuarios);
    $("#filtro-tipo").on('change', filtrarUsuarios);

    /*Swal.fire({
        title: 'Do you want to save the changes?',
        showDenyButton: true,
        showCancelButton: true,
        confirmButtonText: 'Confirmar',
        denyButtonText: `No!`,
        cancelButtonText: 'Cancelar',
        //timer: 2500 //<- auto cerrado
    }).then((result) => {
        console.log(result)
        if (result.isConfirmed) { // Confirmar
            Swal.fire('¡Guardado!', '', 'success');
        } else if (result.isDenied) { // Rechazar
            Swal.fire('¡Rechazado!', '', 'info');
        } else if (result.isDismissed) { // Cancelar
            Swal.fire('¡Cancelado!', '', 'info');
        }
    })*/
});

function cargarNumeroMaximoUsuarios() {
    $.ajax({
        url: "./webservices/ws-num-usuarios.php",
        type: "get",
        error : function (error){
            alert(error);
            numeroTotalUsuarios = 0;
        }
    })
    .then((respuesta)=> {
        if (!isNaN(respuesta.num_usuarios)) numeroTotalUsuarios = respuesta.num_usuarios;
        else numeroTotalUsuarios = 0;

        cogerUsuarios();
    });
}

function cogerUsuarios() {
    if (numeroTotalUsuarios <= 0) { 
        mostrarNoUsuariosRegistrados(); 
        return; // No ejecutamos el resto
    }

    // Petición AJAX para coger X usuarios
    if (paginaActual < 1) {
        paginaActual = 1;
    }
    let inicio = (paginaActual - 1) * (numeroElementos * numVecesCargar) + (numeroElementos * numVecesCargado);
    let fin = numeroElementos;

    // Petición
    let data = {
        inicio : inicio,
        fin    : fin,
        filtro_nombre : $("#search").val(),
        filtro_tipo : $("#filtro-tipo").val()
    }

    $.ajax({
        url: "./webservices/ws-usuarios.php",
        type: "post",
        data : data,
        error : function (error) {
            alert(error);
        }
    })
    .then((respuesta)=> {
        if (respuesta.length > 0) volcarUsuarios(respuesta);
        else mostrarMensajeSinUsuarios();

    // Añadimos hasta 5 veces, y después mostramos botón de pasar página y ocultamos botón cargar más
    if (numVecesCargado >= numVecesCargar) {
        $("#cargar-mas-usuarios").prop('disabled', true);
        $("#siguiente-pag-usuarios").removeClass('display-none');
        $("#anterior-pag-usuarios").removeClass('display-none');
    }
    });

}


function mostrarNoUsuariosRegistrados() {
    $("#usuarios-registrados").html('');
    $("#usuarios-registrados").append('<tr class="usuarios-no-data"><td colspan="3"><p>No existen usuarios registrados</p></td></tr>');
}

function mostrarMensajeSinUsuarios() {
    if (!filtro) $("#usuarios-registrados").append('<tr class="usuarios-no-more-data"><td colspan="3">No hay más usuarios registrados</td></tr>');
    else {
        if (numVecesCargado > 0) {
            $("#usuarios-registrados").append('<tr class="usuarios-no-more-data"><td colspan="3">No hay más usuarios que cumplan los criterios</td></tr>');
        } else {
            $("#usuarios-registrados").append('<tr class="usuarios-no-more-data"><td colspan="3">Ningún usuario cumple los criterios</td></tr>');
        }
    }
    $("#cargar-mas-usuarios").prop('disabled', true); // <- Si no hay más usuarios, deshabilitamos el botón
    $("#siguiente-pag-usuarios").prop('disabled', true); // <- Si no hay más usuarios, deshabilitamos el botón
}

// Recorre todos los usuarios, los consturye en HTML y los añade
function volcarUsuarios(usuarios) {
    let contenido = "";
    for (const usuario of usuarios) {
        let tipo = "Cliente";
        if (usuario.tipo == 'V') tipo = "Vendedor"; 
        else if (usuario.tipo == 'A') tipo = "Administrador";

        // Añadimos el contenido de cada usuario
        contenido += `<tr id="${usuario.id}" class="usuario-${tipo.toLowerCase()}">
            <td class="usuario-username clave">${usuario.username}</td>
            <td class="usuario-email dn990">${usuario.email}</td>
            <td class="usuario-tipo dn480">${tipo}</td>
            <td class="usuario-acciones">
                <button type="submit" class="btn btn-ver" onclick="verUsuario(this, ${usuario.id})"> <!-- Ver -->
                    <span class="icon"><ion-icon name="enter-outline"></ion-icon></span>
                    <span class="title">Ver&nbsp;</span>
                </button>` + 
                ((usuario.habilitado == 0) ? 
                `<button type="submit" class="btn btn-editar" onclick="habilitarUsuario(this, ${usuario.id})"> <!-- Habilitar -->
                    <span class="icon"><ion-icon name="create-outline"></ion-icon></span>
                    <span class="title">Habilitar&nbsp;</span>
                </button>
                ` : 
                `<button type="submit" class="btn btn-editar" onclick="deshabilitarUsuario(this, ${usuario.id})"> <!-- Deshabilitar -->
                    <span class="icon"><ion-icon name="create-outline"></ion-icon></span>
                    <span class="title">Deshabilitar&nbsp;</span>
                </button>
                `) + 
                `
                <button type="submit" class="btn btn-eliminar" onclick="eliminarUsuario(this, ${usuario.id})"> <!-- Eliminar -->
                    <span class="icon"><ion-icon name="close-circle-outline"></ion-icon></span>
                    <span class="title">Eliminar&nbsp;</span>
                </button>
            </td>
        </tr>
        `;
    }

    numVecesCargado++;
    $("#usuarios-registrados").append(contenido);
    comprobarDisponibilidadPaginas();
}

// Recibe otra tanda de usuarios a cargar (simulando lazy load, pero cada vez que clica)
function mostrarMasUsuarios(){
    cogerUsuarios();
}

// Carga la siguiente página de usuarios
function siguientePagUsuarios() {
    paginaActual++;
    numVecesCargado = 0;
    vaciarYCogerUsuarios();
    $("#cargar-mas-usuarios").prop('disabled', false);
    $("#anterior-pag-usuarios").prop('disabled', false);
    $("#siguiente-pag-usuarios").addClass('display-none');
}

// Carga la página anterior de usuarios
function anteriorPagUsuarios() {
    paginaActual--;
    numVecesCargado = 0;
    vaciarYCogerUsuarios();
    if (paginaActual <= 1) {
        $("#anterior-pag-usuarios").prop('disabled', true);
        $("#anterior-pag-usuarios").addClass('display-none');
    }
    $("#siguiente-pag-usuarios").prop('disabled', false);
    $("#cargar-mas-usuarios").prop('disabled', false);
}

function vaciarYCogerUsuarios() {
    // Limpiamos el contenido actual de la lista para volcar lo siguiente
    $("#usuarios-registrados").html('');

    // Volcamos lo siguiente
    cogerUsuarios();
}

function comprobarDisponibilidadPaginas() {
    // Si no pudieramos cargar más registros, deshabilitamos página siguiente
    if ((paginaActual * numeroElementos * numVecesCargar) >= numeroTotalUsuarios) {
        $("#siguiente-pag-usuarios").prop('disabled', true);
    }
    
}

/* Mostrar input para buscar usuario cuando hay poco espacio */
function mostrarInputBusqueda() {
    if ($(window).width() < 330) {
        let valor = $("#search").val();

        Swal.fire({
            title: 'Filtrar',
            input: 'text',
            inputAttributes: {
                placeholder: '',
                value: valor,
                autocapitalize: 'off'
            },
            showCancelButton: true,
            confirmButtonText: 'Buscar',
            cancelButtonText: 'Cancelar',
            showLoaderOnConfirm: true,
            allowOutsideClick: false,
            preConfirm: (search) => {
                return { search: search }
            }
        }).then((result) => {
            if (result.isConfirmed) {
                $("#search").val(result.value.search.trim());
                filtrarUsuarios();
            }
        });
    } else {

    }
}

/* Ver, deshabilitar y eliminar usuario */
// Muestra una alerta para ver los datos del usuario seleccionado
function verUsuario(target, id) {
    // Obtenemos los datos del usuario
    let data = {
        id: id,
        accion: "obtener"
    };
    $.ajax({
        url: "./webservices/ws-usuario-acciones.php",
        type: "post",
        data:  data,
    })
    .then((respuesta) => {
        if (respuesta.exito) { // Si ha recogido datos con éxito, mostramos usuario
            let datos = respuesta.datos_usuario;
            // Parseamos el tipo
            let tipo;
            if (datos.tipo.toUpperCase() == 'A') tipo = `<p class="usuario-tipo-admin">Administrador</p>`;
            else if (datos.tipo.toUpperCase() == 'V') tipo = `<p class="usuario-tipo-vendedor">Vendedor</p>`;
            else tipo = `<p class="usuario-tipo-cliente">Cliente</p>`;
            // Parseamos habilitado
            let habilitado = datos.habilitado == 0 ? `<p class="usuario-deshabilitado">Deshabilitado</p>` : `<p class="usuario-habilitado">Habilitado</p>`;
            // Parseamos foto
            let foto = (datos.foto == null) ? "default_user.png" : datos.foto;
            // Parseamos descripción
            let desc = (datos.descripcion == null) ? `<p class="usuario-desc no-desc">Sin descripción...</p>` : `<p class="usuario-desc">${datos.descripcion}</p>`;
            // Mostramos los datos
            Swal.fire({
                html:
                    `<h3>${datos.username}</h3>
                    <img class="usuario-imagen" src="../img/usuarios/${foto}">
                    <p>${datos.email}</p>
                    ${desc}
                    ${tipo}
                    ${habilitado}`,
                showCloseButton: true,
                confirmButtonText: 'Volver'
            });

        } else {
            throw Error('error');
        }
    })
    .catch((err) => { // Si se encuentra algún error
        Swal.fire({
            title: 'Error al obtener el usuario :(',
            confirmButtonText: 'Oh, vaya',
            icon: "error"
        });
    });
    
} 

// Muestra alerta con botones para habilitar el usuario seleccionado
function habilitarUsuario(target, id) {
    Swal.fire({
        title: '¿Quieres habilitar el usuario?',
        showCancelButton: true,
        confirmButtonText: '¡Sí!',
        cancelButtonText: 'Mejor déjalo',
        icon: "question"
    }).then((result) => {
        if (result.isConfirmed) { // Habilitamos el usuario
            let data = {
                id: id,
                accion: "habilitar"
            };
            $.ajax({
                url: "./webservices/ws-usuario-acciones.php",
                type: "post",
                data:  data,
            })
            .then((respuesta) => {
                if (respuesta.exito) {
                    // Si se habilita con éxito, alert y cambiar el botón
                    target.children[1].innerText = "Deshabilitar ";
                    $(target).off("click");
                    target.addEventListener("click",  () => {
                        deshabilitarUsuario(target, id); 
                    });
                    Swal.fire({
                        title: '¡Usuario habilitado!',
                        confirmButtonText: '¡Ok!',
                        icon: "success",
                        timer: 1500
                    });
                } else {
                    throw Error('error');
                }
            })
            .catch((err) => { // Si no se habilita con éxito
                Swal.fire({
                    title: 'Error al habilitar el usuario :(',
                    confirmButtonText: 'Oh, vaya',
                    icon: "error"
                });
            });
        }
    });
} 

// Muestra alerta con botones para deshabilitar el usuario seleccionado
function deshabilitarUsuario(target, id) {
    Swal.fire({
        title: '¿Quieres deshabilitar el usuario?',
        showCancelButton: true,
        confirmButtonText: '¡Sí!',
        cancelButtonText: 'Mejor déjalo',
        icon: "question"
    }).then((result) => {
        if (result.isConfirmed) { // Deshabilitamos el usuario
            let data = {
                id: id,
                accion: "deshabilitar"
            };
            $.ajax({
                url: "./webservices/ws-usuario-acciones.php",
                type: "post",
                data:  data,
            })
            .then((respuesta) => {
                if (respuesta.exito) {
                    // Si se deshabilita con éxito, alert y cambiar el botón
                    target.children[1].innerText = "Habilitar ";
                    $(target).off("click");
                    target.addEventListener("click",  () => {
                        habilitarUsuario(target, id); 
                    });
                    Swal.fire({
                        title: '¡Usuario deshabilitado!',
                        confirmButtonText: '¡Ok!',
                        icon: "success",
                        timer: 1500
                    });
                } else {
                    throw Error('error');
                }
            })
            .catch((err) => { // Si no se habilita con éxito
                Swal.fire({
                    title: 'Error al deshabilitar el usuario :(',
                    confirmButtonText: 'Oh, vaya',
                    icon: "error"
                });
            });
        }
    });
} 
function eliminarUsuario(target, id) {
    Swal.fire({
        title: '¡Estás a punto de eliminar un usuario!\n¿Are you sure, mate?',
        showCancelButton: true,
        confirmButtonText: '¡Sí!',
        cancelButtonText: 'Mejor déjalo',
        icon: "warning"
    }).then((result) => {
        if (result.isConfirmed) { // Deshabilitamos el usuario
            let data = {
                id: id,
                accion: "eliminar"
            };
            $.ajax({
                url: "./webservices/ws-usuario-acciones.php",
                type: "post",
                data:  data,
            })
            .then((respuesta) => {
                if (respuesta.exito) {
                    // Si se elimina, borramos la celda
                    document.getElementById(id).remove();
                    
                    Swal.fire({
                        title: 'Usuario elminado, ¡bye bye!',
                        confirmButtonText: '¡Ok!',
                        icon: "success",
                        timer: 1500
                    });
                } else {
                    throw Error('error');
                }
            })
            .catch((err) => { // Si no se habilita con éxito
                Swal.fire({
                    title: 'Error al eliminar el usuario :(',
                    confirmButtonText: 'Oh, vaya',
                    icon: "error"
                });
            });
        }
    });
} 

/* Filtrar usuarios */

// Si aprieta una tecla, comenzamos cuenta atrás de 700ms, si lleva 700ms sin escribir, procede a filtrar, así evitamos petar el WS a consultas
var keydownTimeOut;
function keydownFiltrarUsuarios() {
    clearTimeout(keydownTimeOut);
    keydownTimeOut = setTimeout(filtrarUsuarios, 700);
}

function filtrarUsuarios() {
    paginaActual = 0;
    numVecesCargado = 0;
    $("#anterior-pag-usuarios").prop('disabled', true);
    $("#anterior-pag-usuarios").addClass('display-none');
    $("#siguiente-pag-usuarios").prop('disabled', false);
    $("#siguiente-pag-usuarios").addClass('display-none');
    $("#cargar-mas-usuarios").prop('disabled', false);

    if (!$("#search").val() && !$("#filtro-tipo").val()) filtro = false;
    else filtro = true;

    vaciarYCogerUsuarios();
}