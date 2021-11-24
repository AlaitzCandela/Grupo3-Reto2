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
        username: $('#login input[name="username"]').val().trim(),
        password: $('#login input[name="password"]').val().trim(),
        accion: $('#login input[name="accion"]').val(),
    }

    $form = $(this);
    $.ajax({
        url: "./webservices/ws-login.php",
        type: "post",
        data:  data
    })
    .then((respuesta) => {
        console.log(respuesta);
        if (respuesta.login) {
            // Guardamos el id del usuario
            document.cookie = "id_usuario=" + respuesta.id_usuario;
            document.cookie = "foto=" + respuesta.foto;

            // Usamos el sistema de rutas tope genial
            window.location.href = './home.php';
        } else {
            // Vaciamos la contraseña para que la vuelva a introducir
            $('#login input[name="password"]').val('');
            
            // Mostramos error por credenciales incorrectas
            throw Error("Credenciales incorrectas");
        }
    })
    .catch((err) => {
        Swal.fire({
            title: 'Usuario y/o contraseña incorrectos',
            icon: 'error',
            showDenyButton: true,
            confirmButtonText: 'Ok',
            denyButtonText: '(╯°□°）╯︵ ┻━┻',
        }).then((result) => {
            if (result.isDenied) {
                Swal.fire({
                    title: 'Pero, no te enfades :(',
                    icon: 'question',
                    showDenyButton: true,
                    confirmButtonText: '(ヘ･_･)ヘ┳━┳',
                    denyButtonText: 'w(ﾟДﾟ)w',
                }).then((result) => {
                    if (result.isDenied) {
                        Swal.fire({
                            title: '¡Eh! Te relajas',
                            icon: 'warning',
                            showDenyButton: true,
                            showCancelButton: true,
                            confirmButtonText: 'Perdón',
                            cancelButtonText: '(;´༎ຶД༎ຶ`)', 
                            denyButtonText: '(╬▔皿▔)╯',
                        }).then((result) => {
                            if (result.isDenied) {
                                Swal.fire({
                                    title: 'Never...',
                                    icon: 'error',
                                    confirmButtonText: '??',
                                }).then((result) => {
                                    window.location.href = "https://www.youtube.com/watch?v=dQw4w9WgXcQ";
                                });
                            }
                        });
                    } else if (result.isDismissed) {
                        Swal.fire({
                            title: 'No te preocupes, todo saldrá bien',
                            icon: 'info',
                            confirmButtonText: '(* ￣3)(ε￣ *)',
                        })
                    }
                });
            }
        });
        $('#login input[name="password"]').val('');
    });

});
 

$('#register').submit((e) => {
    e.preventDefault();

    // Utilizaremos FormData para mandar los datos
    var form_data = new FormData();    

    // Añadimos los datos al FormData para enviarlo en la petición
    // ficheros -> $_FILES
    let img = $('#profile-pic')[0].files[0];
    if (img != undefined) form_data.append('img', img);
    // variables -> $_POST
    form_data.append('nombre_carpeta', "usuarios");
    form_data.append('username', $('#register input[name="username"]').val().trim());
    form_data.append('password', $('#register input[name="password"]').val().trim());
    form_data.append('email', $('#register input[name="email"]').val().trim());
    form_data.append('accion', $('#register input[name="accion"]').val());

    $form = $(this);
    $.ajax({
        url: "./webservices/ws-register.php",
        dataType: 'json',
        cache: false,
        contentType: false,
        processData: false,
        data: form_data,                         
        type: 'post',
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
                document.cookie = "foto=" + respuesta.foto;

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