Spine = require('spine')
Display = require('controllers/display')
ModelFunction = require('controllers/model_function')

class Fitter extends Spine.Controller
  className: 'fitter-controller'

  constructor: ->
    super
    @display = new Display()
    @modelFunction = new ModelFunction()

  active: ->
    super
    @render
    @append @display,@modelFunction

  render: ->
    @html require("views/fitter")(@)
 
module.exports = Fitter
