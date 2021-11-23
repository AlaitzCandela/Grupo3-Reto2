document.querySelectorAll('nav ul li').forEach((evt) => {
    evt.classList.remove('selected');
    document.querySelector('#menuPerfil').classList.add('selected')
});

$('#btnVendedor').on('click', (evt) => {
    $('.modal').css("display", "flex");
});

document.querySelector('#profile-pic-input').onchange = evt => {
    const [file] = document.querySelector('#profile-pic-input').files
    if (file) {
        document.querySelector('#preview-profile-pic').src = URL.createObjectURL(file);
    } else {
        document.querySelector('#preview-profile-pic').src = "../img/usuarios/default_user.png";
    }
}
    
$("#btnBorrarImagen").on('click',() => {
    document.querySelector('#preview-profile-pic').src = '../img/usuarios/default_user.png';
    $('#img-input').prop('value',null);
})

$("textarea").each(function () {
    this.setAttribute("style", "height:" + (this.scrollHeight) + "px;overflow-y:hidden;");
    }).on("input", function () {
    this.style.height = "auto";
    this.style.height = (this.scrollHeight) + "px";
});