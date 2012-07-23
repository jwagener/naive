//= require_tree ./vendor
//= require_self
//= require_tree ./naive
//= require nighthawks

window.NAIVE = {}
class NAIVE.Game
  frame: 0
  constructor: (options) ->
    @$e = $(".canvas")
    @actor = new NAIVE.Actor()
    document.title = @title
    @$e.live "click", @onClick
    @loopInterval = window.setInterval @runLoop, 125
    @initializeDebug()

  runLoop: () =>
    @actor.update()

  stopLoop: ->
    window.clearInterval @loopInterval

  onClick: (e) =>
    e.preventDefault()
    p = new NAIVE.P(e.offsetX, e.offsetY)

    if area = @findAreaForPoint(p)
      area.onClick(p, @game, @actor)
      console.log("Found area", area)
    #game.actor.target = p
    console.log "Click on: " + p.toString()

  findAreaForPoint: (point) ->
    foundArea = null
    for areaCollection in [@walkAreas]
      for area in areaCollection
        if area.polygon.isPointWithin(point)
          foundArea = area
    foundArea

  initializeDebug: ->
    @debugCanvas = @setupDebugCanvas()

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
