// Arrays para las gráficas
var mediaPlataforma = [];
var num_ventas_por_mes = [];
var num_ganancias_por_mes = [];

function eliminarAnuncio(evt, id) {
	Swal.fire({
		title: '¡Ojo cuidao!',
		text: 'Vas a eliminar un anuncio y no habrá vuelta atrás, ¿quieres unirte al lado oscuro y eliminar el anuncio?',
		icon: 'question',
		showCancelButton: true,
		confirmButtonText: 'Dale calor',
		cancelButtonText: 'Mejor no'
	}).then((response) => {
		if (response.isConfirmed) {
			ejecutarEliminarAnuncio(evt, id);
		}
	});
}

function ejecutarEliminarAnuncio(evt, id) {
	let data = {
		id_anuncio : id,
		accion: "eliminar-anuncio"
	}
	$.ajax({
		url: "./webservices/ws-eliminar-anuncio.php",
		type: "post",
		data : data
	})
    .then((respuesta) => {
        if (respuesta.exito) {
            Swal.fire({
                title: 'Bye bye!',
                text: '¡Anuncio eliminado con éxito!',
                icon: 'success',
                timer: 2500,
                confirmButtonText: 'Okay!',
            }).then(() => {
				if (evt.target.id == "span-nieto") {
					evt.target.parentElement.parentElement.remove();
				} else {
					evt.target.parentElement.remove();
				}
            });
        } else {
            throw Error('err');
        }
    })
    .catch((err) => {
        Swal.fire({
            title: 'Error',
            text: 'No hemos podido eliminar el anuncio :(',
            icon: 'error',
            confirmButtonText: 'Oh, vaya',
        });
    });
}
/*
<?php if ($privilegios_borrar): ?>
                                    <span onclick="eliminarAnuncio(event, <?= $anuncio['id'] ?>)">
                                        <span id="span-nieto">Borrar</span>
                                    </span>
                                <?php else: ?>
                                    <span class="spdisabled" disabled>
                                        <span disabled id="span-nieto">Borrar</span>
                                    </span>
                                <?php endif; ?> */

function cargarTodosLosAnuncios() {
	let data = {
		id_vendedor : $("#id-vendedor").val(),
		accion: "cargar-anuncios-vendedor"
	}
	$.ajax({
		url: "./webservices/ws-cargar-anuncios-vendedor.php",
		type: "post",
		data : data
	})
    .then((respuesta) => {
		if (respuesta.exito) {
			let contenido = "<div><span>Nombre del producto</span><span>Enlace</span><span>Acci&oacute;n</span></div>";
			for (const anuncio of respuesta.anuncios) {
				let elemento_borrar = ($('#pb').val() == 'true') ? `<span onclick="eliminarAnuncio(event, ${anuncio.id})">
						<span id="span-nieto">Borrar</span>
					</span>` : `<span class="spdisabled" disabled>
					<span disabled id="span-nieto">Borrar</span>
				</span>`;

				contenido += `<div class="anuncioLista">
					<span>${anuncio.nombre}</span>
					<span><a href="./detalle-anuncio.php?id=${anuncio.id}">Ver ${($('#pb').val() == 'true') ? "mi" : "el"} anuncio</a></span>
					${elemento_borrar}
				</div>`;
			}
			document.getElementById('misAnuncios').innerHTML = contenido;
		} else {
			throw Error("err");
		}
	}).catch((err) => {
		Swal.fire({
            title: 'Error',
            text: 'No hemos podido cargar los anuncios :(',
            icon: 'error',
            confirmButtonText: 'Oh, vaya',
        });
	});
}

/* DOCUMENT READY */
$(document).ready(() => {
	$("#verTodo").on('click', cargarTodosLosAnuncios);

    document.querySelectorAll('nav ul li').forEach((evt) => {
        evt.classList.remove('selected');
        document.querySelector('#menuHome').classList.add('selected');
    });

	// Cargamos las gráficas
	num_ganancias_por_mes = $("#valores-ganancias-mes").val().split(",");
	num_ventas_por_mes = $("#valores-ventas-mes").val().split(",");
	mediaPlataforma = $("#valores-ventas-media").val().split(",");
	
	/* JS GRÁFICAS */
	var ctx = document.getElementById("graficoLineas").getContext("2d");
	var ctxCircular = document.getElementById("graficoCircular").getContext("2d");
	var labels = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"];
	let width, height, gradient;


	function getGradient(ctx, chartArea) {
		const chartWidth = chartArea.right - chartArea.left;
		const chartHeight = chartArea.bottom - chartArea.top;
		if (!gradient || width !== chartWidth || height !== chartHeight) {
			// Create the gradient because this is either the first render
			// or the size of the chart has changed
			width = chartWidth;
			height = chartHeight;
			gradient = ctx.createLinearGradient(0, chartArea.bottom, 0, chartArea.top);
			gradient.addColorStop(0, "#ce99ff");
			gradient.addColorStop(0.5, "#ffc476");
			gradient.addColorStop(1, "#5cc894");
		}

		return gradient;
	}


	var data = {
		labels: labels,
		datasets: [
			{
				label: "Num. Ventas",
				borderColor: function(context) {
						const chart = context.chart;
						const {ctx, chartArea} = chart;
			
						if (!chartArea) {
						// This case happens on initial chart load
						return;
						}
						return getGradient(ctx, chartArea);
				},
				lineTension: .1,
				pointColor: "rgba(220,220,220,1)",
				pointStrokeColor: "#fff",
				pointHighlightFill: "#fff",
				pointHighlightStroke: "rgba(220,220,220,1)",
				data: num_ventas_por_mes
			},
			{
				label: "Media de la plataforma",
				borderColor: "#287bff",
				lineTension: .2,
				pointRadius: 2,
				pointHoverRadius: 5,
				pointColor: "rgba(220,220,220,1)",
				pointStrokeColor: "#fff",
				pointHighlightFill: "#fff",
				pointHighlightStroke: "rgba(220,220,220,1)",
				data: mediaPlataforma
			}
		]
	};


	const data2 = {
		labels: labels,
		datasets: [
			{
				label: 'Dataset 1',
				data: num_ganancias_por_mes,
				backgroundColor: [
					"#ce99ff",
					"#99a0ff",
					"#99f0ff",
					"#b6ff99",
					"#ffee99",
					"#ffa599",
					"#ff99ff",
					"#ff7373",
					"#f2f2f2",
					"#ffc476",
					"#5cc894",
					"#287bff"
				]
			}
		]
	};


	const graficaLineas = new Chart(ctx, {
		type: 'line',
		data: data,
		options: {
			responsive: true,
			plugins: {
				legend: {
				position: 'top',
				},
				title: {
				display: true,
				text: 'Ventas'
				}
			},
			scales: {
				x: {
					grid: {
						display: true,
						color: "rgba(255,255,255,.3)"
					}
				},
				y: {
					grid: {
						display: true,
						color: "rgba(255,255,255,.3)"
					}
				}
			},
		}
	});


	const graficaCircular = new Chart(ctxCircular ,{
		type: 'polarArea',
		data: data2,
		options: {
			responsive: true,
			plugins: {
			legend: {
				position: 'top',
			},
			title: {
				display: true,
				text: 'Ganancias'
			}
			},
			scales: {
				r: {
					grid: {
						circular: true,
						color: "rgba(255,255,255,.3)"
					}
				}
			}
		},
	});
});

