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



$("textarea").each(function () {
    this.setAttribute("style", "height:" + (this.scrollHeight) + "px;overflow-y:hidden;");
  }).on("input", function () {
    this.style.height = "auto";
    this.style.height = (this.scrollHeight) + "px";
});



function cerrarSesion(){
  document.cookie = "id_usuario=,max-age=0";
  window.location.href = "./login.view.php";
}
