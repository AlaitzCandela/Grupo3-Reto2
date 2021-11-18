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

imgInp.onchange = evt => {
    const [file] = imgInp.files
    if (file) {
      document.querySelector('#preview').src = URL.createObjectURL(file);
    }
}

$("textarea").each(function () {
    this.setAttribute("style", "height:" + (this.scrollHeight) + "px;overflow-y:hidden;");
  }).on("input", function () {
    this.style.height = "auto";
    this.style.height = (this.scrollHeight) + "px";
});