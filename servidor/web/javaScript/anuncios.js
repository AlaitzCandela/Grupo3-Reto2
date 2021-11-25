var paginaActual = 1;
var numeroElementos = 10; // Elementos a cargar cada vez
var numVecesCargado = 1; // Cargamos 5 veces y después mostramos pasar página
var anuncios_favoritos = []; //Array con todos los id de los anuncios favoritos
var anuncios_carrito = [];
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

    // Cargamos cookies favoritos
    let cookies = document.cookie.split('; ');
    let favoritos = cookies.find((elm) => elm.includes('favoritos'));
    if (favoritos) { // Si ya existían los favoritos, los recogemos
        let ids_favoritos = favoritos.split("=")[1];
        anuncios_favoritos = ids_favoritos.split(",");
    }

    // Cargamos cookies carrito
    let carrito = cookies.find((elm) => elm.includes('carrito'));
    if (carrito) { // Si ya existían los carrito, los recogemos
        let ids_carrito = carrito.split("=")[1];
        anuncios_carrito = ids_carrito.split(",");
    }

    // Cargamos anuncios
    cogerAnuncios();
    $("#mas").on('click', mostrarMasAnuncios);

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
    let inicio = (numeroElementos * (numVecesCargado - 1));
    let fin = numeroElementos;
    // TODO filtro
    let filtro = "";

    let data = {
        inicio : inicio,
        fin : fin,
        filtro: filtro
    }
    $.ajax({
        url: "./webservices/ws-mostrar-anuncios.php",
        type: "post",
        data : data,
        error : function (error){
            alert(error);
        }
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
    $("#boton").append('<p style="color:white;">No hay más anuncios disponibles</p>');
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
