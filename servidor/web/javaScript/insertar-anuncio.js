$(document).ready(() => {
    cogerCategorias();
    $("#enviarDatos").click(insertarAnuncio);
});

function cogerCategorias(){
    $.ajax({
        url: "./webservices/ws-insertarAnuncios.php",
        type: "post",
        error: function(error){
            alert(error);
        }
    })
    .then((categorias)=>{
       // console.log(categorias);
        let contenido = "";
        for (const categoria of categorias) {
                contenido += `<div>
                <input type="checkbox" name="categoria" value="${categoria.id}" id="cat${categoria.id}" class="categoria-check">
                <label for="cat${categoria.id}">${categoria.nombre}</label>
                </div>`
            }
        $(".categorias").append(contenido);
    }
            
    )
}

function insertarAnuncio(evt){
    evt.preventDefault();
    $('#form-subir-anuncio').submit((e) => {
        e.preventDefault();

        let nombre = $("#nombre-anuncio").val();
        let descripcion = $("#descripcion").val();
        let caducidad = $("#caducidad").val();
        let precio = $("#precio").val();
    
        let categoriasTotal = $(".categoria-check:checked");
        let categorias_ids = [];
        
        for (const categoria of categoriasTotal) {
            categorias_ids.push(categoria.value);
        }
    
        let formData = new FormData();
        //formData.append($("#form-subir-anuncio"),$("#form-subir-anuncio")[0][0].files);
        //console.log(formData.files)
        console.log($('#img-input')[0].files[0])
        console.log($('#img-input').result)
    
        let datos = {
            nombre : nombre,
            descripcion : descripcion,
            caducidad : caducidad,
            precio : precio,
            foto : formData,
            categorias : categorias_ids.join(',')
        }
        console.log(datos)
    /*
        $.ajax({
            url:"./insertar-anuncios.php",
            type:"post",
            data: datos,
            error: function(error){
                alert(error)
            }
        })
        .then((response) => {
            console.log(response)
            if (response.exito) {
                // Si ha insertado bien, redirigimos
            } else {
                alert('Imposible registrar el anuncio')
            }
        }); */
    });
}