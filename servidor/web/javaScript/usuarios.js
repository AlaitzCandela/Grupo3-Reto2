var paginaActual = 1;
var paginaTope;
var numeroTotalUsuarios;
var numeroElementos = 10; // Elementos a cargar cada vez
var numVecesCargado = 0; // Cargamos 5 veces y después mostramos pasar página

$(document).ready(() => {
    // Petición que primero obtiene número total de usuarios y luego los obtiene
    cargarNumeroMaximoUsuarios();

    // Preparamos los listeners
    $("#cargar-mas-usuarios").on('click', mostrarMasUsuarios);
    $("#anterior-pag-usuarios").on('click', anteriorPagUsuarios);
    $("#siguiente-pag-usuarios").on('click', siguientePagUsuarios);
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
    let inicio = (paginaActual - 1) * numeroElementos + (numeroElementos * numVecesCargado);
    let fin = numeroElementos;
    let filtro = ""; // TODO dani: obtener filtro

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
    });
    // Volcar esos usuarios en el HTML

    // Añadimos hasta 5 veces, y después mostramos botón de pasar página y ocultamos botón cargar más
    if (numVecesCargado >= 5) {
        $("#siguiente-pag-usuarios").prop('hidden', false);
        $("#cargar-mas-usuarios").prop('hidden', true);
    }
}


function mostrarNoUsuariosRegistrados() {
    $("#usuarios-registrados").html('');
    $("#usuarios-registrados").append('<tr class="usuarios-no-data"><td colspan="2"><p>No existen usuarios registrados</p></td></tr>');
}

function mostrarMensajeSinUsuarios() {
    $("#usuarios-registrados").append('<tr class="usuarios-no-more-data"><td colspan="2">No hay más usuarios registrados</td></tr>');
    $("#cargar-mas-usuarios").prop('disabled', true); // <- Si no hay más usuarios, deshabilitamos el botón
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
                <form action="usuarios.php"> <!-- Ver -->
                    <input type="hidden" name="accion" value="ver">
                    <input type="hidden" name="id" value="${usuario.id}">
                    <button type="submit" class="btn btn-ver">
                        <span class="icon"><ion-icon name="enter-outline"></ion-icon></span>
                        <span class="title">Ver</span>
                    </button>
                </form>
                <form action="usuarios.php"> <!-- Editar -->
                    <input type="hidden" name="accion" value="editar">
                    <input type="hidden" name="id" value="${usuario.id}">
                    <button type="submit" class="btn btn-editar">
                        <span class="icon"><ion-icon name="create-outline"></ion-icon></span>
                        <span class="title">Editar</span>
                    </button>
                </form>
                <form action="usuarios.php"> <!-- Eliminar -->
                    <input type="hidden" name="accion" value="eliminar">
                    <input type="hidden" name="id" value="${usuario.id}">
                    <button type="submit" class="btn btn-eliminar">
                        <span class="icon"><ion-icon name="close-circle-outline"></ion-icon></span>
                        <span class="title">Eliminar</span>
                    </button>
                </form>
            </td>
        </tr>
        `;
    }

    $("#usuarios-registrados").append(contenido);
    comprobarDisponibilidadPaginas();
}

// Recibe otra tanda de usuarios a cargar (simulando lazy load, pero cada vez que clica)
function mostrarMasUsuarios(){
    paginaActual++;
    numVecesCargado++;
    cogerUsuarios();
}

// Carga la siguiente página de usuarios
function siguientePagUsuarios() {
    paginaActual++;
    vaciarYCogerUsuarios() ;
}

// Carga la página anterior de usuarios
function anteriorPagUsuarios() {
    paginaActual--;
    vaciarYCogerUsuarios() ;
}

function vaciarYCogerUsuarios() {
    // Limpiamos el contenido actual de la lista para volcar lo siguiente
    $("#usuarios-registrados").html('');

    // Volcamos lo siguiente
    cogerUsuarios();
}

function comprobarDisponibilidadPaginas() {
    // Si estamos en la página 1, deshabilitamos página anterior
    if (paginaActual == 1) {
        $("#anterior-pag-usuarios").prop('disabled', true);
    }

    // Si no pudieramos cargar más registros, deshabilitamos página siguiente
    if ((paginaActual * numeroElementos) >= numeroTotalUsuarios) {
        $("#siguiente-pag-usuarios").prop('disabled', true);
    }
    
}