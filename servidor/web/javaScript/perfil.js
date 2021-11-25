$(document).ready(() => {
    let formModal = document.querySelector('.modal');
    if (formModal) formModal.innerHTML += "<button id='cancelar' onclick='ocultarModal()'>Cancelar</button>";

    document.querySelectorAll('nav ul li').forEach((evt) => {
        evt.classList.remove('selected');
        document.querySelector('#menuPerfil').classList.add('selected');
    });
});

function ocultarModal() {
    $('.modal').css("display", "none");
}

$('#btnVendedor').on('click', (evt) => {
    $('.modal').css("display", "flex");
});

document.querySelector('#profile-pic-input').onchange = evt => {    
    const [file] = document.querySelector('#profile-pic-input').files
    if (file) { 
        document.getElementById('btnBorrarImagen').innerHTML = "Borrar imagen";
        document.querySelector('#preview-profile-pic').src = URL.createObjectURL(file);
    }
}
    
$("#btnBorrarImagen").on('click',(evt) => {
    if (evt.target.innerHTML.includes("Añadir")) {
        $('#profile-pic-input').click();
        document.getElementById('btnBorrarImagen').innerHTML = "Borrar imagen";
        return;
    } else {
        document.getElementById('btnBorrarImagen').innerHTML = "Añadir imagen";
    }
    document.querySelector('#profile-pic-input').value = "";
    document.querySelector('#preview-profile-pic').src = '../img/usuarios/default_user.png';
})

$("textarea").each(function () {
    this.setAttribute("style", "height:" + (this.scrollHeight) + "px;overflow-y:hidden;");
    }).on("input", function () {
    this.style.height = "auto";
    this.style.height = (this.scrollHeight) + "px";
});