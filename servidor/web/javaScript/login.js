$('#animacionRegistro').on('click',cambiarSelectedReg);
$('#animacionLogin').on('click',cambiarSelectedIni);

function cambiarSelectedReg() {
    let registro = document.querySelector('.registro');
    let iniciosesion = document.querySelector('.inicio-sesion');
    if(!registro.classList.contains('selected')) {
        iniciosesion.classList.toggle('selected');
        registro.classList.toggle('selected');
    }
}

function cambiarSelectedIni() {
    let registro = document.querySelector('.registro');
    let iniciosesion = document.querySelector('.inicio-sesion');
    if(!iniciosesion.classList.contains('selected')) {
        registro.classList.toggle('selected');
        iniciosesion.classList.toggle('selected');
    }
}

 // Submit del login
 $('#login').submit((e) => {
    e.preventDefault();

    let data = {
        username: $('#login input[name="username"]').val(),
        password: $('#login input[name="password"]').val(),
        accion: $('#login input[name="accion"]').val(),
    }

    $form = $(this);
    $.ajax({
        url: "./webservices/ws-login.php",
        type: "post",
        data:  data,
        error: function(error) {
            // Error en la petición
            alert("error");
        }
    })
    .then((respuesta) => {
        console.log(respuesta);
        if (respuesta.login) {
            // Guardamos el id del usuario
            document.cookie = "id_usuario=" + respuesta.id_usuario;
            
            // Usamos el sistema de rutas tope genial
            window.location.href = './home.php';
        } else {
            // Mostramos error por credenciales incorrectas
            
            // Vaciamos la contraseña para que la vuelva a introducir
            $('#login input[name="password"]').val('');
        }
    })
    .catch((err) => {
        alert("error");
        $('#login input[name="password"]').val('');
    });

});


$('#register').submit((e) => {
    e.preventDefault();

    let data = {
        username: $('#register input[name="username"]').val(),
        password: $('#register input[name="password"]').val(),
        email:    $('#register input[name="email"]').val(),
        accion: $('#register input[name="accion"]').val(),
    }

    $form = $(this);
    $.ajax({
        url: "./webservices/ws-register.php",
        type: "post",
        data:  data,
        error: function(error) {
            // Error en la petición
            alert("error");
        }
    })
    .then((respuesta) => {
        console.log(respuesta);
        if (respuesta.register) {
            if (respuesta.id_usuario > 0) { // Registrado con éxito
                // Guardamos el id del usuario
                document.cookie = "id_usuario=" + respuesta.id_usuario;

                // Usamos el sistema de rutas tope genial
                window.location.href = './home.php';
            } else { // Error al registrar (ya existía)
                // TODO: alert
                $('#register input[name="password"]').val('');
            }
            
        } else {
            // Error en la BBDD
            $('#register input[name="password"]').val('');
        }
    })
    .catch((err) => {
        alert("error");
        $('#register input[name="password"]').val('');
    });

});