models =
  sersic: (modelData,width,height,params) ->
    for x in [0..(width-1)]
      x_cent = x - params.center.x
      x_sqr = x_cent*x_cent
      for y in [(height-1)..0]
        y_cent = y - params.center.y
        r = Math.sqrt(x_sqr + y_cent*y_cent)
        exponent = params.coeff*Math.pow(r/params.effRadius,1/params.n) - 1
        modelData[y*width+x] = params.intensity*Math.exp(-exponent)
    undefined

module?.exports = models
