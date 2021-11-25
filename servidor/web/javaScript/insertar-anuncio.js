$(document).ready(() => {
    $('#caducidad').on('input', function() {
        let value = $('#caducidad').prop('value');
        document.getElementById('valorCaducidad').innerHTML = value + " D&iacute;as";
    });

    $("textarea").each(function () {
        this.setAttribute("style", "height:" + (this.scrollHeight) + "px;overflow-y:hidden;");
      }).on("input", function () {
        this.style.height = "auto";
        this.style.height = (this.scrollHeight) + "px";
    });

    imgInp.onchange = evt => {
        $("#btnBorrarImagen").css('display','block');
        $("#preview").css('display','inline');
        $('#placeholder').css('display','none');
        $('#placeholder-img').css('display','none');
        const [file] = imgInp.files
        if (file) {
          document.querySelector('#preview').src = URL.createObjectURL(file);
        }
      };

    $("#btnBorrarImagen").on('click',() => {
        $('#img-input').prop('value',null);
        document.querySelector('#preview').src = '#';
        $("#btnBorrarImagen").css('display','none');
        $('#preview').css('display','none');
        $('#placeholder').css('display','block');
        $('#placeholder-img').css('display','inline-block');
    });

    cogerCategorias();
    $("#form-insertar-anuncio").on('submit', insertarAnuncio);

    document.querySelectorAll('nav ul li').forEach((evt) => {
        evt.classList.remove('selected');
        document.querySelector('#menuSubirAnuncio').classList.add('selected');
    });
});

function cogerCategorias(){
    $.ajax({
        url: "./webservices/ws-categorias-disponibles.php",
        type: "post",
        error: function(error) {
            alert(error);
        }
    })
    .then((categorias)=>{
       // console.log(categorias);
        let contenido = "";
        if (categorias.codError == 503) {
            window.location.href = "./error-503.php";
            return;
        }
        for (const categoria of categorias) {
                contenido += `<div>
                <input type="checkbox" name="categoria" value="${categoria.id}" id="cat${categoria.id}" class="categoria-check">
                <label for="cat${categoria.id}">${categoria.nombre}</label>
                </div>`
            }
        $(".categorias").append(contenido);
    });
}

function insertarAnuncio(e){
    e.preventDefault();

    let categoriasTotal = $(".categoria-check:checked");
    if (categoriasTotal.length <= 0) { // TODO dani: cambiar por sweet alert
        alert('Selecciona al menos una categoría');
        return;
    }
 
    // Utilizaremos FormData para mandar los datos
    var form_data = new FormData();    

    // Preparamos las categorias anuncio
    let categorias_ids = [];
    for (const categoria of categoriasTotal) {
        categorias_ids.push(categoria.value);
    }

    // Añadimos los datos al FormData para enviarlo en la petición
    // ficheros -> $_FILES
    let img = $('#img-input')[0].files[0];
    if (img != undefined) form_data.append('img', img);
    // variables -> $_POST
    form_data.append('nombre_carpeta', "anuncios");
    form_data.append('nombre', $("#nombre-anuncio").val().trim());
    form_data.append('descripcion', $("#descripcion").val().trim());
    form_data.append('caducidad', $("#caducidad").val());
    form_data.append('precio', $("#precio").val());
    form_data.append('categorias', categorias_ids.join(","));

    // Realizamos la petición
    $.ajax({
        url: "./webservices/ws-insertar-anuncio.php",
        dataType: 'json',
        cache: false,
        contentType: false,
        processData: false,
        data: form_data,                         
        type: 'post',
        error: function(error){
            alert(error)
        }
    })
    .then((response) => {
        console.log(response)
        if (response.codError == 503) {
            window.location.href = "./error-503.php";
            return;
        }
        if (!response.exito) {
            // Analizamos el código de error
            switch(response.codError) {
                case 1: // Error por imagen: demasiado grande
                    alert('Imagen demasiado grande (máximo 10 megas)')
                    break;
                case 2: // Error por imagen: no es una imagen ò.ó
                    alert('No es una imagen, cuidado con lo que intentas, ¿eh?')
                    break;
                case 3: // Error por imagen: formato no soportado
                    alert('Formato de imagen no soportado')
                    break;
                case 4: // Error por imagen: imposible guardarla
                    alert('Error al guardar la imagen :(')
                    break;
                case 5: // Error al insertar el anuncio
                    alert('Error al crear el anuncio, el nombre ya existe')
                    break;
                case 6: // Error al insertar las categorías del anuncio
                    alert('Error al asociar las categorías al anuncio :(')
                    break;
                case 7: // Error al asociar el vendedor al anuncio
                    alert('Error al asociar el vendedor al anuncio')
                    break;
                default: // Sweet alert con error genérico
                    alert('Error desconocido')
            }
        }
        console.log(datos)
    });
}