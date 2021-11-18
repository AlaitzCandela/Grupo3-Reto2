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