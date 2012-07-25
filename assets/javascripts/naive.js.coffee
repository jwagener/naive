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
    @walkAreas = options.walkAreas || []
    @itemAreas = options.itemAreas || []
    document.title = @title
    @$e.find(".click-layer").bind "click", @onClick
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

    if area = @findAreaForPoint(p)
      area.onClick(p, @, @actor)
    else
      @actor.goCloseTo(p)

  findAreaForPoint: (point) ->
    foundArea = null
    for areaCollection in [@itemAreas, @walkAreas]
      for area in areaCollection
        if area.polygon.isPointWithin(point)
          return foundArea = area
    foundArea

  findClosestPointInWalkingAreaForPoint: (point) ->
    for y in [(point.y)..@height]
      currentPoint = new NAIVE.P(point.x, y)
      for area in @walkAreas
        if area.polygon.isPointWithin(currentPoint)
          return currentPoint
    null

  showMessage: (point, message, color, callback) ->
    $message = $("<span class='message' />").text(message).css
      top: point.y
      left: point.x
      color: color

    $message.appendTo(@$e)

    window.setTimeout (->
      $message.remove()
      callback() if callback?
    ), 2000

  initializeDebug: ->
    @debugCanvas = @setupDebugCanvas()

  setupDebugCanvas: ->
    canvas = $(".canvas")
    c = $("<canvas class='debugCanvas'/>").appendTo(canvas)
    c.attr("width", canvas.width())
    c.attr("height", canvas.height())
    window.ctx = c[0].getContext("2d")

  debugAreas: ->
    for areaCollection in [@itemAreas, @walkAreas]
      for area in areaCollection
        area.polygon.toCanvas(@debugCanvas)
