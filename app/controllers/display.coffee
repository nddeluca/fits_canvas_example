Spine = require('spine')

class Display extends Spine.Controller
  className: 'display-controller'

  constructor: ->
    super

  active: ->
    super
    @render

  render: =>
    @html require('views/display')(@)

module.exports = Display
