$(document).ready(() => {
    let formModal = document.querySelector('.modal');
    if (formModal) formModal.innerHTML += "<button id='cancelar' onclick='ocultarModal()'>Cancelar</button>";

    document.querySelectorAll('nav ul li').forEach((evt) => {
        evt.classList.remove('selected');
        document.querySelector('#menuPerfil').classList.add('selected');
    });

    $("#form-perfil").on('submit', actualizarPerfil);
});

function actualizarPerfil(e) {
    e.preventDefault();

    if ($('#password').val().trim() != $('#reppassword').val().trim()) {
        Swal.fire({
            title: '¡Ey!',
            text: 'Las contraseñas no coinciden',
            icon: 'error',
            confirmButtonText: 'Ok',
        });

        return false;
    }

    // Utilizaremos FormData para mandar los datos
    var form_data = new FormData();    

    // Añadimos los datos al FormData para enviarlo en la petición
    // ficheros -> $_FILES
    let img = $('#profile-pic-input')[0].files[0];
    if (img != undefined) form_data.append('img', img);
    // variables -> $_POST
    form_data.append('nombre_carpeta', "usuarios");
    form_data.append('username', $('#nombreUsuario').val().trim());
    form_data.append('password', $('#password').val().trim());
    form_data.append('descripcion', $('#descripcionUsuario').val().trim());
    form_data.append('accion', 'actualizar');

    $.ajax({
        url: "./webservices/ws-register.php",
        dataType: 'json',
        cache: false,
        contentType: false,
        processData: false,
        data: form_data,                         
        type: 'post'
    })
    .then((respuesta) => {
        if (respuesta.exito) {
            Swal.fire({
                title: '¡Hecho!',
                text: '¡Datos actualizados con éxito!',
                icon: 'success',
                timer: 2500,
                confirmButtonText: '¡Perfecto!',
            }).then(() => {
                if (respuesta.img_guardada) document.cookie = "foto=" + respuesta.foto;
                location.reload();
            });
        } else {
            throw Error('err');
        }
    })
    .catch((err) => {
        Swal.fire({
            title: 'Error',
            text: 'No hemos podido actualizar tus datos :(',
            icon: 'error',
            confirmButtonText: 'Oh, vaya',
        });
        $('#password').val('');
        $('#reppassword').val('');
    });
}

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