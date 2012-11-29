Spine = require('spine')

class ModelFunction extends Spine.Controller
  className: 'model-controller'

  constructor: ->
    super
  
  active: ->
    super
    @render

  render: =>
    console.log "render"
    @html require("views/model_function")(@)

module.exports = ModelFunction
