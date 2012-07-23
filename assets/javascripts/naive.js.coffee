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
    @actor.position = new NAIVE.P(-150, 550)
    @walkAreas = options.walkAreas
    document.title = @title
    @$e.bind "click", @onClick
    @$e.live "touchstart", (e) ->
      console.log(e, e.offsetX)
      game.onClick(e)
    @initializeDebug()
    @startLoop()

  runLoop: () =>
    @actor.update()

  startLoop: ->
    @loopInterval = window.setInterval @runLoop, 125

  stopLoop: ->
    window.clearInterval @loopInterval

  onClick: (e) =>
    e.preventDefault()
    p = new NAIVE.P(e.offsetX, e.offsetY)
    console.log p.toString()

    console.log(p, @findAreaForPoint(p) )
    if area = @findAreaForPoint(p)
      area.onClick(p, @game, @actor)

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
