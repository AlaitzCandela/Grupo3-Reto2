let toggle = document.querySelector('.toggle');
let nav = document.querySelector('nav');
let main = document.querySelector('main');
let topbar = document.querySelector('.topbar');
let imgInp = document.querySelector('#img-input');

toggle.onclick = function() {
    nav.classList.toggle('active');
    main.classList.toggle('active');
    topbar.classList.toggle('active');
}

$('#favoritos').on('click',() => {
  if($('#favoritos').prop('name') == 'star-outline') {
    $('#favoritos').prop('name','star');
  }
  else {
    $('#favoritos').prop('name','star-outline');
  }
  document.querySelector('#favoritos').classList.toggle('seleccionado');
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
}

$("#btnBorrarImagen").on('click',() => {
  $('#img-input').prop('value',null);
  document.querySelector('#preview').src = '#';
  $("#btnBorrarImagen").css('display','none');
  $('#preview').css('display','none');
  $('#placeholder').css('display','block');
  $('#placeholder-img').css('display','inline-block');
})

$("textarea").each(function () {
    this.setAttribute("style", "height:" + (this.scrollHeight) + "px;overflow-y:hidden;");
  }).on("input", function () {
    this.style.height = "auto";
    this.style.height = (this.scrollHeight) + "px";
});

$('#caducidad').on('input', function() {
    let value = $('#caducidad').prop('value');
    document.getElementById('valorCaducidad').innerHTML = value + " D&iacute;as";
})

function cerrarSesion(){
  document.cookie = "id_usuario=,max-age=0";
  window.location.href = "./login.view.php";
}
