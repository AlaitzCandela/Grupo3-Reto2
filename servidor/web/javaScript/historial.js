$(document).ready(() => {
    document.querySelectorAll('nav ul li').forEach((evt) => {
        evt.classList.remove('selected');
        document.querySelector('#menuHistorial').classList.add('selected');
    });
})