require('lib/setup')
Spine = require('spine')
Fitter = require('controllers/fitter')

class App extends Spine.Controller
  constructor: ->
    super
    @fitter = new Fitter()
    @append @fitter.active()

module.exports = App
    
