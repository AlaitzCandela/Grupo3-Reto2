var paginaActual = 1;
var numeroElementos = 10; // Elementos a cargar cada vez
var numVecesCargado = 1; // Cargamos 5 veces y después mostramos pasar página

$(document).ready(() => {
    // Cargamos los anuncios iniciales
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
        console.log(respuesta)
        if (respuesta.length > 0) volcarAnuncios(respuesta);
        else mostrarMensajeSinAnuncios();
    });
    // Volcar esos anuncios en el HTML

    // Añadimos hasta 5 veces, y después mostramos botón de pasar página
    
}




function mostrarMensajeSinAnuncios() {
    // TODO: personalizar mensaje con clase
    $("#cuadricula-anuncios").append('<p>No hay más anuncios disponibles</p>');
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
        contenido += `<div class="anuncio" style="color:white !important;" id="${anuncio.id}">
            <h2>${anuncio.nombre}</h2>
            <img src="../img/anuncios/${url_foto}" alt="" style="max-width:80px !important;">
            <p>${anuncio.precio}</p>
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