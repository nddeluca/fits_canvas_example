class Residual
  constructor: (@width,@height) ->
    @buffer = new ArrayBuffer(@width*@height*4)
    @data = new Float32Array(@buffer)

module?.exports = Residual
