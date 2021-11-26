// Variables globales
var paginaActual = 1;
var numeroElementos = 10; // Elementos a cargar cada vez
var numVecesCargado = 0; // Cargamos 5 veces y después mostramos pasar página
var anuncios_favoritos = []; //Array con todos los id de los anuncios favoritos
var anuncios_carrito = [];

var botonMasOculto = false;

// Filtros
var filtro = "";
var filtro_nombre = "";
var boolean_favoritos = false;

$(document).ready(() => {
    // Sumamos visita
    if ($("#id-anuncio")) {
        let data = {
            id_anuncio : $("#id-anuncio").val()
        }
        $.ajax({
            url: "./webservices/ws-sumar-visita.php",
            type: "post",
            data : data
        });
    }

    // Animación filtros
    $('.filtros-container').css('top', '-'+($('.filtros-container').prop('clientHeight')+100)+'px');

    $('.filtro').on('click', (evt)=> {
        document.querySelector('.filtros-container').classList.toggle('showing');
    });

    $('#aplicarFiltros').on('click', (evt) => {
        evt.target.parentElement.classList.toggle('showing');
    });

    $('.filtroButton').on('click', (evt) => {
        evt.target.classList.toggle('seleccionado');
    });

    $('#resetearFiltros').on('click', (evt) => {
        $('.filtroButton').each((index, element) => {
            element.classList.remove('seleccionado');
        });
        evt.target.parentElement.classList.toggle('showing');
    });

    $("#search").keydown(keydownFiltrarAnuncios);

    // Cargamos cookies favoritos
    let cookies = document.cookie.split('; ');
    let favoritos = cookies.find((elm) => elm.includes('favoritos'));
    if (favoritos) { // Si ya existían los favoritos, los recogemos
        let ids_favoritos = favoritos.split("=")[1];
        anuncios_favoritos = ids_favoritos.split(",");
    }
    if (anuncios_favoritos[0] == '') anuncios_favoritos = [];

    // Cargamos cookies carrito
    let carrito = cookies.find((elm) => elm.includes('carrito'));
    if (carrito) { // Si ya existían los carrito, los recogemos
        let ids_carrito = carrito.split("=")[1];
        anuncios_carrito = ids_carrito.split(",");
    }

    // Cargamos anuncios
    cogerAnuncios();

    // Marcamos anuncios en el menú lateral
    document.querySelectorAll('nav ul li').forEach((evt) => {
        evt.classList.remove('selected');
    });
    if (document.getElementById('menuAnuncios')) {
        document.querySelector('#menuAnuncios').classList.add('selected');
    } else {
        document.querySelector('#menuHome').classList.add('selected');
    }
});

function cogerAnuncios(){
    // Petición AJAX para coger X anuncios
    if (paginaActual < 1) {
        paginaActual = 1;
    }
    let inicio = (numeroElementos * numVecesCargado);
    let fin = numeroElementos;

    let data = {
        inicio : inicio,
        fin : fin,
        filtro: filtro_nombre + filtro
    }
    $.ajax({
        url: "./webservices/ws-mostrar-anuncios.php",
        type: "post",
        data : data
    })
    .then((respuesta)=> {
        if (respuesta.codError == 503) {
            window.location.href = "./error-503.php";
            return;
        }
        if (respuesta.length > 0) volcarAnuncios(respuesta);
        else mostrarMensajeSinAnuncios();
    });
}


function mostrarMensajeSinAnuncios() {
    if (numVecesCargado == 0) {
        if (boolean_favoritos) {
            if (anuncios_favoritos.length > 0 && anuncios_favoritos != ['']) $("#boton").append('<p style="color:white;">No hay favoritos que cumplan los filtros</p>');
            else $("#boton").append('<p style="color:white;">No tienes ningún producto en favoritos</p>');
        }
        else $("#boton").append('<p style="color:white;">No hay nada que mostrar</p>');
    }
    else $("#boton").append('<p style="color:white;">No hay más anuncios disponibles</p>');
    
    $("#mas").css("display","none");
}

// Recorre todos los anuncios, los consturye en HTML y los añade
function volcarAnuncios(anuncios) {
    let contenido = "";
    for (const anuncio of anuncios) {
        let url_foto = anuncio.foto;
        if (url_foto == null || url_foto == undefined || url_foto == "") {
            url_foto = "default_anuncio.svg";
        }
        // Añadimos el contenido de cada anuncio
        contenido += `<div class="anuncio" id="${anuncio.id}" onclick="irDetalle(${anuncio.id})">
            <h2>${anuncio.nombre}</h2>
            <div class='imagen'>
                <img src="../img/anuncios/${url_foto}" alt="" ">
            </div>
            <p>${anuncio.precio}&euro;</p>
            <p>${anuncio.fecha_publicacion}</p>
        </div>
        `;  
    }

    $("#cuadricula-anuncios").append(contenido);
}

function mostrarMasAnuncios(){
    numVecesCargado++;
    cogerAnuncios();
}

function irDetalle(id){
    window.location.href="./detalle-anuncio.php?id="+id;
}

function favoritos(id) {
    // Obtenemos la posición del id en la cookie, si no existe, devuelve -1
    let posicion = anuncios_favoritos.indexOf(anuncios_favoritos.find(elm => elm == id));
    if (posicion < 0) { // Si no existía, lo está añadiendo como favoritos
        anuncios_favoritos.push(id);
    } else { // Si existe, lo está eliminando de favoritos
        anuncios_favoritos.splice(posicion, 1);
    }

    if (anuncios_favoritos.length <= 0) { // Si ha eliminado el último de favoritos, eliminamos la cookie en sí
        document.cookie = "favoritos=;max-age=0";
    } else { // Si existen valores en favoritos, simplemente guardamos o reemplazamos la cookie favoritos
        document.cookie = "favoritos=" + anuncios_favoritos;
    }
}

$('#anadirCarrito').on('click',() => {
    if($('#anadirCarrito').prop('name') == 'bag-add-outline') {
      $('#anadirCarrito').prop('name','bag-remove-outline');
      document.querySelector('#anadirCarrito').classList.toggle('rojo');
    }
    else {
      $('#anadirCarrito').prop('name','bag-add-outline');
      document.querySelector('#anadirCarrito').classList.toggle('rojo');
    }
});

function anadirCarrito(id){
    let posicion = anuncios_carrito.indexOf(anuncios_carrito.find(elm => elm == id));
    if (posicion < 0) { // Si no existía, lo está añadiendo como carrito
        anuncios_carrito.push(id);
    } else { // Si existe, lo está eliminando de carrito
        anuncios_carrito.splice(posicion, 1);
    }

    if (anuncios_carrito.length <= 0) { // Si ha eliminado el último de carrito, eliminamos la cookie en sí
        document.cookie = "carrito=;max-age=0";
    } else { // Si existen valores en carrito, simplemente guardamos o reemplazamos la cookie carrito
        document.cookie = "carrito=" + anuncios_carrito;
    }
}


// Aplicar filtros
function parsearFiltros() {
    let filtros_seleccionados = document.querySelectorAll(".filtros-container .filtroButton.seleccionado");
    filtro = "";
    boolean_favoritos = false;

    let numCategoriasSeleccionadas = filtros_seleccionados.length;
    let array_ids_categorias = [];
    if (filtros_seleccionados.length > 0) {
        for (const filtro_seleccionado of filtros_seleccionados) {
            if (filtro_seleccionado.innerHTML == "Favoritos") {
                boolean_favoritos = true;
                numCategoriasSeleccionadas--;
            } else {
                array_ids_categorias.push(filtro_seleccionado.id.split("-")[1])
            }
        }
    }

    if (boolean_favoritos) {
        filtro += ` AND id in (${anuncios_favoritos.join(",")}) `;
    }
    if (numCategoriasSeleccionadas > 0) {
        filtro += ` AND id in (SELECT id_anuncio FROM categoriasAnuncios WHERE id_categoria IN (${array_ids_categorias.join(",")})) `;
    }

    aplicarFiltro();
}

// Resetear filtros
function resetearFiltro() {
    $('#search').val("");
    filtro = "";
    boolean_favoritos = false;
    filtrarAnuncios();
}

function aplicarFiltro() {
    numVecesCargado = 0;
    $("#cuadricula-anuncios").html('');
    cogerAnuncios();
    $("#boton").html('<button onclick="mostrarMasAnuncios()" id="mas">M&aacute;s</button>');
    $("#mas").css("display","inline-block");
}

// Si aprieta una tecla, comenzamos cuenta atrás de 700ms, si lleva 700ms sin escribir, procede a filtrar, así evitamos petar el WS a consultas
var keydownTimeOut;
function keydownFiltrarAnuncios() {
    clearTimeout(keydownTimeOut);
    keydownTimeOut = setTimeout(filtrarAnuncios, 700);
}

function filtrarAnuncios() {
    filtro_nombre = " AND nombre LIKE '%" + $('#search').val().trim() + "%'";
    aplicarFiltro();
}