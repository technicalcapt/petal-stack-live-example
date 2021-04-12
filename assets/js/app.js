// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
import "phoenix_html"
import {Socket} from "phoenix"
import LiveSocket from "phoenix_live_view"
import topbar from "topbar"
import "alpinejs"
import Chart from 'chart.js/auto'

const initPieChart = (canvas) => {
  let dataStr = canvas.dataset.qualities
  let data = dataStr.split(",").map(str => parseInt(str))
  let ctx = canvas.getContext("2d")
  let pieChart = new Chart(ctx, {
    type: "pie",
    data: {
      labels: ["A-I", "J-R", "S-Z"],
      datasets: [{
        label: "User Ratings",
        data: data,
        backgroundColor: [
          'rgba(226, 137, 242, 1)',
          'rgba(0, 0, 0, 1)',
          'rgba(133, 92, 248, 1)'
        ],
        hoverOffset: 4
      }]
    },
    options: {
      layout: {
        padding: {
          top: 24,
          bottom: 24
        }
      }
    }
  })
}

let Hooks = {}

Hooks.InitChart = {
  mounted() {
    initPieChart(this.el)
  },
  updated() {
    initPieChart(this.el)
  }
}

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {
  hooks: Hooks,
  params: {_csrf_token: csrfToken},
  dom: {
    onBeforeElUpdated(from, to){
      if(from.__x){ window.Alpine.clone(from.__x, to) }
    }
  },
})

// Connect if there are any LiveViews on the page
liveSocket.connect()

// Expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)
// The latency simulator is enabled for the duration of the browser session.
// Call disableLatencySim() to disable:
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", info => topbar.show())
window.addEventListener("phx:page-loading-stop", info => topbar.hide())
