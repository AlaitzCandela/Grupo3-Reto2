$(document).ready((evt) => {
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
            element.parentElement.parentElement.classList.toggle("favorito");
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

