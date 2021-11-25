var paginaActual = 1;
var numeroElementos = 10; // Elementos a cargar cada vez
var numVecesCargado = 1; // Cargamos 5 veces y después mostramos pasar página
var anuncios_favoritos = []; //Array con todos los id de los anuncios favoritos
$(document).ready(() => {
    // Cargamos los anuncios iniciales
    let cookies = document.cookie.split('; ');
    let favoritos = cookies.find((elm) => elm.includes('favoritos'));
    if (favoritos) { // Si ya existían los favoritos, los recogemos
        let ids_favoritos = favoritos.split("=")[1];
        anuncios_favoritos = ids_favoritos.split(",");
    }
    console.log(anuncios_favoritos)
    if ($("#id-anuncio")) {
        let id_anuncio = $("#id-anuncio").val();
        console.log(id_anuncio);
    }
    cogerAnuncios();
    $("#mas").click(mostrarMasAnuncios);
});

function cogerAnuncios(){
    // Petición AJAX para coger X anuncios
    if (paginaActual < 1) {
        paginaActual = 1;
    }
    let inicio = (paginaActual - 1) * numeroElementos;
    let fin = numeroElementos;


    let data = {
        inicio : inicio,
        fin : fin
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
    // Volcar esos anuncios en el HTML

    // Añadimos hasta 5 veces, y después mostramos botón de pasar página
    
}




function mostrarMensajeSinAnuncios() {
    // TODO: personalizar mensaje con clase
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
    paginaActual++;
    cogerAnuncios();
}

function irDetalle(id){
    window.location.href="./detalle-anuncio.php?id="+id;
}

function favoritos(id) {
    // Obtenemos la posición del id en la cookie, si no existe, devuelve -1
    let posicion = anuncios_favoritos.indexOf(anuncios_favoritos.find(elm => elm == id));
    console.log(posicion)
    if (posicion < 0) { // Si no existía, lo está añadiendo como favoritos
        anuncios_favoritos.push(id);
    } else { // Si existe, lo está eliminando de favoritos
        anuncios_favoritos.splice(posicion);
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