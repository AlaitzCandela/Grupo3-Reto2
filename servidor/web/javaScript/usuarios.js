var paginaActual = 1;
var paginaTope;
var numeroTotalUsuarios;
var numVecesCargar = 5; // Cuantas veces hay que cargar antes de pasar página
var numeroElementos = 10; // Elementos a cargar cada vez
var numVecesCargado = 0; // Número de veces cargado

$(document).ready(() => {
    // Petición que primero obtiene número total de usuarios y luego los obtiene
    cargarNumeroMaximoUsuarios();

    // Preparamos los listeners
    $("#cargar-mas-usuarios").on('click', mostrarMasUsuarios);
    $("#anterior-pag-usuarios").on('click', anteriorPagUsuarios);
    $("#siguiente-pag-usuarios").on('click', siguientePagUsuarios);

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
        console.log(respuesta.num_usuarios)
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
    let filtro = ""; // TODO dani: obtener filtro

    console.log(inicio + " " + fin + " " + numVecesCargado)
    console.log("SELECT id,username,email,tipo FROM usuarios LIMIT"+ inicio + ", "+ fin)

    let data = {
        inicio : inicio,
        fin    : fin,
        filtro : filtro
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
        console.log(respuesta)
        if (respuesta.length > 0) volcarUsuarios(respuesta);
        else mostrarMensajeSinUsuarios();

    // Añadimos hasta 5 veces, y después mostramos botón de pasar página y ocultamos botón cargar más
    if (numVecesCargado >= numVecesCargar) {
        $("#siguiente-pag-usuarios").removeClass('display-none');
        $("#anterior-pag-usuarios").removeClass('display-none');
    }
    });

}


function mostrarNoUsuariosRegistrados() {
    $("#usuarios-registrados").html('');
    $("#usuarios-registrados").append('<tr class="usuarios-no-data"><td colspan="2"><p>No existen usuarios registrados</p></td></tr>');
}

function mostrarMensajeSinUsuarios() {
    $("#usuarios-registrados").append('<tr class="usuarios-no-more-data"><td colspan="2">No hay más usuarios registrados</td></tr>');
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


/* Ver, deshabilitar y eliminar usuario */
function verUsuario(target, id) {
    // TODO dani
} 
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
                url: "./webservices/ws-usuario-habilitar.php",
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
                url: "./webservices/ws-usuario-habilitar.php",
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
    // TODO dani
} 