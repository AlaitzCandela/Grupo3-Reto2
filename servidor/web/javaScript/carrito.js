var anuncios_carrito = [];
var anuncios_favoritos = []; //Array con todos los id de los anuncios favoritos

$(document).ready((evt) => {
    let cookies = document.cookie.split('; ');
    let carrito = cookies.find((elm) => elm.includes('carrito'));
    if (carrito) { // Si ya existían los carrito, los recogemos
        let ids_carrito = carrito.split("=")[1];
        anuncios_carrito = ids_carrito.split(",");
    }
    let favoritos = cookies.find((elm) => elm.includes('favoritos'));
    if (favoritos) { // Si ya existían los favoritos, los recogemos
        let ids_favoritos = favoritos.split("=")[1];
        anuncios_favoritos = ids_favoritos.split(",");
    }

    document.querySelectorAll('nav ul li').forEach((evt) => {
        evt.classList.remove('selected');
        document.querySelector('#menuCarrito').classList.add('selected');
    });

    let nombres = document.querySelectorAll('.carrito .producto .nombreProducto a');
    nombres.forEach(element => {
        element.innerHTML=element.innerHTML.replace(/\s/g, "&nbsp;");
    });

    document.querySelectorAll('.carrito .producto .acciones .toggleFavorito').forEach(element => {
        element.onclick = function () {
            if(element.firstChild.name=="star-outline") {
                element.firstChild.name="star";
            }
            else {
                element.firstChild.name="star-outline";
            }
        }
    });

    document.querySelectorAll('.carrito .producto.favorito .acciones .toggleFavorito ion-icon').forEach(element => {
        element.name = "star";
    });
})

function eliminarDeCesta(id, precio){
    let posicion = anuncios_carrito.indexOf(anuncios_carrito.find(elm => elm == id));
    if (posicion >= 0) { // Si existe, lo está eliminando de carrito
        anuncios_carrito.splice(posicion, 1);
        document.getElementById('carrito-producto-' + id).remove();

        let precio_total = Number(document.getElementById('precioTotalValor').innerHTML); 
        precio_total = precio_total - Number(precio);

        document.getElementById('precioTotalValor').innerHTML=precio_total;

        // Si es el último, mostramos sin productos
        if (document.querySelectorAll('.producto').length <= 0) {
            let div = document.createElement('div');
            div.classList.add('producto');
            div.innerHTML = `<div class="nombreProducto"><a href="./anuncios.php">Sin productos en la cesta.</a></div>`;
            document.getElementById('carrito-productos').prepend(div);
        }
    }
    if (anuncios_carrito.length <= 0) { // Si ha eliminado el último de carrito, eliminamos la cookie en sí
        document.cookie = "carrito=;max-age=0";
    } else { // Si existen valores en carrito, simplemente guardamos o reemplazamos la cookie carrito
        document.cookie = "carrito=" + anuncios_carrito;
    }
}

function vaciarCarrito(){
    document.getElementById('precioTotalValor').innerHTML = 0;
    document.querySelectorAll('.producto').forEach(e => e.remove());
    let div = document.createElement('div');
    div.classList.add('producto');
    div.innerHTML = `<div class="nombreProducto"><a href="./anuncios.php">Sin productos en la cesta.</a></div>`;
    document.getElementById('carrito-productos').prepend(div);
        
    document.cookie = "carrito=;max-age=0";
}


function clickFavoritos(id) {
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

function comprarCarrito() {
    console.log("hola")
    if (anuncios_carrito.length > 0) {
        let id_comprador = -1;
        try {
            id_comprador = document.cookie.split("; ").find((elm) => elm.includes("id_usuario")).split("=")[1];
        } catch (error) {
            // TODO dani: sweet alert error al cargar usuario contacta soporte
            return;
        }
        
        let data = {
            id_comprador : id_comprador,
            id_anuncios : anuncios_carrito,
            accion : "comprar-carrito"
        }
        $.ajax({
            url: "./webservices/ws-comprar-carrito.php",
            type: "post",
            data:  data
        })
        .then((respuesta) => {
            console.log(respuesta); 
            if (respuesta.exito) {
                // TODO dani: alerta carrito comprado con éxito
                vaciarCarrito();
                window.location.href = "./home.php";
            } else {
                // TODO dani: alerta personalizada con error
            }
        });


    } else {
        // TODO dani: sweet alert no puedes comprar sin tener nada añadido bro
    }
}