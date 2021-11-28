let toggle = document.querySelector('.toggle');
let nav = document.querySelector('nav');
let main = document.querySelector('main');
let topbar = document.querySelector('.topbar');
let imgInp = document.querySelector('#img-input');

try {
  toggle.onclick = function() {
      nav.classList.toggle('active');
      main.classList.toggle('active');
      topbar.classList.toggle('active');
  } 
} catch (err) { /* en el login esta parte no se podrá ejecutar y mostraría un error en consola, así lo evitamos */ }

// Cambio de color y forma del icono de favoritos
$('#favoritos').on('click',() => {
  if($('#favoritos').prop('name') == 'star-outline') {
    $('#favoritos').prop('name','star');
  }
  else {
    $('#favoritos').prop('name','star-outline');
  }
  document.querySelector('#favoritos').classList.toggle('seleccionado');
});

/* Este método cambia el tamaño de los textareas para
   que se comporten de forma responsiva.
*/
$("textarea").each(function () {
    this.setAttribute("style", "height:" + (this.scrollHeight) + "px;overflow-y:hidden;");
  }).on("input", function () {
    this.style.height = "auto";
    this.style.height = (this.scrollHeight) + "px";
});


function registrarVendedor(evt, id) {
  evt.preventDefault();

  let data = {
    id_usuario: id,
    telefono: $("#telefono").val(),
    direccion: $("#direccion").val(),
    accion: "registrar-vendedor"
  };
  $.ajax({
      url: "./webservices/ws-registrar-vendedor.php",
      type: "post",
      data:  data,
  }).then((response) => {
    if (response.exito) {
      Swal.fire({
        title: '¡Hecho!',
        text: 'Ya estás registrado como vendedor ¡hurra!\n \\(≧▽≦)/',
        icon: 'success',
        confirmButtonText: '¡Perfecto!',
      }).then((result) => {
          location.reload();
      });
    } else {
      Swal.fire({
        title: 'Error',
        text: 'Algo ha salido mal al registrarte como vendedor :(',
        icon: 'error',
        confirmButtonText: 'Oh, vaya',
      });
    }
  })
}

function cerrarSesion() {
  document.cookie = "id_usuario=;max-age=0";
  document.cookie = "carrito=;max-age=0";
  document.cookie = "favoritos=;max-age=0";
  window.location.href = "./login.php";
}
