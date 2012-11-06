require('lib/setup')
FitsCanvas = require('fits_canvas')

Spine = require('spine')

class App extends Spine.Controller
  constructor: ->
    super
    xhr = new XMLHttpRequest()
    xhr.open('GET', 'images/cutout.fits')
    xhr.responseType = 'arraybuffer'
		
    xhr.send()
    @render()

    xhr.onload = (e) ->
      start = new Date()

      fitsDisplay = new FitsCanvas.FitsDisplay('container',500,xhr.response)
      init = new Date()

      fitsDisplay.processImage()

      process = new Date()

      fitsDisplay.draw()
      end = new Date()

      console.log "New FitDisplay:", init-start
      console.log "ProcessImage:", process-init
      console.log "draw:", end-process
      console.log "total:", end-start
  
  render: =>
    @html require('views/index')

module.exports = App
    
