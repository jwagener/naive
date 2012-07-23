//= require_tree ./vendor
//= require_self
//= require_tree ./naive
//= require nighthawks

window.NAIVE = {}
class NAIVE.Game
  frame: 0
  constructor: (options) ->
    @actor = new NAIVE.Actor()
    document.title = @title
    @loopInterval = window.setInterval @runLoop, 125
    @initializeDebug()

  runLoop: () =>
    @actor.update()

  stopLoop: ->
    window.clearInterval @loopInterval

  initializeDebug: ->
    @debugCanvas = @setupDebugCanvas()

    $(".canvas").live "click", (e) ->
      e.preventDefault()
      p = new NAIVE.P(e.offsetX, e.offsetY)
      game.actor.target = p
      console.log "Debug: #{p.toString()}"

  setupDebugCanvas: ->
    canvas = $(".canvas")
    c = $("<canvas class='debugCanvas'/>").appendTo(canvas)
    c.attr("width", canvas.width())
    c.attr("height", canvas.height())
    window.ctx = c[0].getContext("2d")

  debugAreas: ->
    for area in @walkAreas
      console.log(area)
      area.polygon.toCanvas(@debugCanvas)

$ ->
  window.game = new Nighthawks()
