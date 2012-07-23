//= require_tree ./vendor
//= require_self
//= require nighthawks

window.NAIVE = {}
class NAIVE.Game
  frame: 0
  constructor: (game) ->
    @game = game

    @actor = new NAIVE.Actor()
    document.title = game.title
    console.log("hi", game)
    window.setInterval @runLoop, 125

    @initializeDebug()


  initializeDebug: ->
    window.drawPolygon = (c, points) ->
      c.fillStyle = 'rgba(200,0,0, 0.5)'
      c.beginPath()
      firstPoint = points.shift()
      c.moveTo(firstPoint.x, firstPoint.y)
      for point in points
        c.lineTo(point.x, point.y)
      c.closePath();
      c.fill();


    canvas = $(".canvas")
    c = $("<canvas />").appendTo(canvas)
    c.css
      position: "absolute"
      top: 0
    c.attr("width", canvas.width())
    c.attr("height", canvas.height())

    window.ctx = c[0].getContext("2d")
    #drawPolygon(ctx, @game.walkareas.front.points)
    #drawPolygon(ctx, @game.walkareas.back.points)

    $(".canvas").live "click", (e) ->
      e.preventDefault()
      p = new NAIVE.P(e.offsetX, e.offsetY)
      game.actor.target = p
      console.log "Debug: #{p.toString()}"

  runLoop: () =>
    @actor.update()

class NAIVE.Actor
  velocity: 10
  target: null
  width: 130
  height: 175
  position: null
  frame: 0
  update: ->
    @frame += 1

    @position = @position.pointBetween(@target, @velocity)
    @updateAnimation()
    @setPosition()

  setPosition: ->
    @e.css
      left: @position.x - (@width/2)
      top: @position.y - @height

  constructor: ->
    @e = $(".actor")
    @target  = new NAIVE.P(400, 400)
    @position = new NAIVE.P(0, 0)

  updateAnimation: ->
    baseAnimation = "stan-walking-right"
    animationFrames = 6
    toBeRemoved = []
    toBeAdded   = []
    for i in [0..animationFrames]
      animationFrameName = "#{baseAnimation}-#{i}"
      if @frame % animationFrames == i
        toBeAdded.push animationFrameName
      else
        toBeRemoved.push animationFrameName
    @e.removeClass(toBeRemoved.join(" ")).addClass(toBeAdded.join(" "))

class NAIVE.P
  toString: -> "#{@x}, #{@y}"
  deg2rad: (d) -> d * Math.PI / 180
  rad2deg: (r) -> r / Math.PI * 180

  pointBetween: (point, distance) ->
    deg = Math.PI / 180.0
    angle = @angleFor(point)
    r = @deg2rad(angle - 90)
    x = Math.round(@x + distance * Math.cos(r))
    y = Math.round(@y + distance * Math.sin(r))
    newPoint = new NAIVE.P(x, y)

  distanceTo: (otherPoint) ->
    x = @x
    y = @y
    x0 = otherPoint.x
    y0 = otherPoint.y
    Math.sqrt((x -= x0) * x + (y -= y0) * y);

  angleFor: (otherPoint) ->
    @coordsToAngle(@x, @y, otherPoint.x, otherPoint.y)

  coordsToAngle: (x1, y1, x2, y2) ->
    (@rad2deg(Math.atan2(x2 - x1, y1 - y2)) + 360) % 360

  constructor: (x, y) ->
    @x = x
    @y = y

$ ->
  window.game = new NAIVE.Game(Nighthawks)
