Residual = require('./residual')

class Model
  constructor: (@fitsImage,@modelFunc,@params) ->
    #Set width and height
    @width = @fitsImage.width
    @height = @fitsImage.height

    @fitsData = @fitsImage.data
    @length = @width*@height

    #Initialize model data array
    @modelBuffer = new ArrayBuffer(@length*4)
    @data = new Float32Array(@modelBuffer)

    #Intialize residual
    @residual = new Residual(@width,@height)
    @residualData = @residual.data

  generate: ->
    @modelFunc(@data,@width,@height,@params)
    undefined

  calculateResidual: ->
    for index in [0..(@length-1)]
      @residualData[index] = @fitsData[index] - @data[index]
    undefined

module?.exports = Model
