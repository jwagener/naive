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
    window.setInterval @runLoop, 250

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
    drawPolygon(ctx, @game.walkareas.front.points)
    drawPolygon(ctx, @game.walkareas.back.points)

    $(".canvas").live "click", (e) ->
      e.preventDefault()
      x = e.offsetX
      y = e.offsetY
      console.log "Debug: #{x}, #{y}"

  runLoop: () =>
    @actor.update()

class NAIVE.Actor
  velocity: 10
  width: 130
  height: 175
  position: null

  update: ->
    $(".actor").toggleClass("stan-waiting-2")
    @position.x += 5
    @setPosition()

  setPosition: ->
    @e.css
      left: @position.x - (@width/2)
      top: @position.y + @height

  constructor: ->
    @e = $(".actor")
    @position = new NAIVE.P(300, 200)

window.NAIVE.P = (x, y) ->
  @x = x
  @y = y

$ ->
  game = new NAIVE.Game(Nighthawks)
