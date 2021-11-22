var ctx = document.getElementById("graficoLineas").getContext("2d");

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
    labels: ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"],
    datasets: [
        {
            label: "Mis ventas",
            borderColor: function(context) {
                const chart = context.chart;
                const {ctx, chartArea} = chart;
        
                if (!chartArea) {
                  // This case happens on initial chart load
                  return;
                }
                return getGradient(ctx, chartArea);
            },
            lineTension: .2,
            pointColor: "rgba(220,220,220,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(220,220,220,1)",
            data: [3, 4, 5, 1, 0, 14, 2, 5, 6, 7, 5, 8]
        },
        {
            label: "Media de la plataforma",
            borderColor: "#287bff",
            lineTension: .2,
            pointColor: "rgba(220,220,220,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(220,220,220,1)",
            data: [4, 2, 3, 4, 5, 8, 5, 2, 1, 4, 2, 12]
        }
    ]
};


const myChart = new Chart(ctx, {
    type: 'line',
    data: data,
    options: {
        responsive: true,
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

var ctxCircular = document.getElementById("graficoCircular").getContext("2d");

const data2 = {
    labels: ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"],
  datasets: [
    {
      label: 'Dataset 1',
      data: [4, 2, 3, 4, 5, 8, 5, 2, 1, 4, 2, 12],
      backgroundColor: [
        "#ce99ff",
        "#ffc476",
        "#5cc894",
        "#287bff"
      ]
    }
  ]
};
const chart2 = new Chart(ctxCircular ,{
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
      }
    },
  });