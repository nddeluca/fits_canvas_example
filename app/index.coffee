require('lib/setup')
FITS = require('fits')
FitsCanvas = require('fits_canvas')
GalaxyModel = require('galaxy_model')
Spine = require('spine')

class App extends Spine.Controller
  constructor: ->
    super
    xhr = new XMLHttpRequest()
    xhr.open('GET', 'images/cutout.fits')
    xhr.responseType = 'arraybuffer'
		
    xhr.send()
    @render()

    xhr.onload = (e) =>
      fitsFile = new FITS.File(xhr.response)
      image = fitsFile.getDataUnit()
      image.getFrame()
      fitsDisplay = new FitsCanvas.Display('fits-container',500,image)
      fitsDisplay.processImage()
      fitsDisplay.draw()

      @sersicParams =
        center:
          x: 31.5
          y: 42
        angle: 0
        axisRatio: 1
        effRadius: 6
        intensity: 2.3
        n: 1

      sersicFunc = GalaxyModel.models.sersic
      
      @model = new GalaxyModel.Model(image,sersicFunc,@sersicParams)
      @model.generate()

      @modelDisplay = new FitsCanvas.Display('model-container',500,@model)
      @modelDisplay.processImage()
      @modelDisplay.draw()

      @model.calculateResidual()
      @residualDisplay = new FitsCanvas.Display('residual-container',500,@model.residual)
      @residualDisplay.processImage()
      @residualDisplay.draw()

      @setParams()
  
  render: =>
    @html require('views/index')

  events:
    "click #fits-container canvas": (e) ->
      canvasOffset = $("#fits-container canvas").offset()
      @sersicParams.center.x = (e.pageX-canvasOffset.left)*@modelDisplay.scaleRatio
      @sersicParams.center.y = @model.height - (e.pageY-canvasOffset.top)*@modelDisplay.scaleRatio
      @setParams()
      @updateModel()
    "click #update": (e) ->
      @getParams()
      @updateModel()
      
  setParams: ->
    $("#centerx").val(@sersicParams.center.x)
    $("#centery").val(@sersicParams.center.y)
    $("#intensity").val(@sersicParams.intensity)
    $("#effRadius").val(@sersicParams.effRadius)
    $("#n").val(@sersicParams.n)
    $("#axisRatio").val(@sersicParams.axisRatio)
    $("#angle").val(@sersicParams.angle)

  getParams: ->
    @sersicParams.center.x = $("#centerx").val()
    @sersicParams.center.y = $("#centery").val()
    @sersicParams.intensity = $("#intensity").val()
    @sersicParams.effRadius = $("#effRadius").val()
    @sersicParams.n = $("#n").val()
    @sersicParams.axisRatio = $("#axisRatio").val()
    @sersicParams.angle = $("#angle").val()
    
  updateModel: ->
    @model.generate()
    @modelDisplay.processImage()
    @modelDisplay.draw()
    @model.calculateResidual()
    @residualDisplay.processImage()
    @residualDisplay.draw()

module.exports = App
    
