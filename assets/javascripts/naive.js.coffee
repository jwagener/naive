//= require_tree ./vendor
//= require_self
//= require_tree ./naive
//= require nighthawks

window.NAIVE = {}
class NAIVE.Game
  frame: 0
  constructor: (game) ->
    @game = game

    @actor = new NAIVE.Actor()
    document.title = game.title
    console.log("hi", game)
    @loopInterval = window.setInterval @runLoop, 125

    @initializeDebug()

  runLoop: () =>
    @actor.update()

  stopLoop: ->
    window.clearInterval @loopInterval

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

$ ->
  window.game = new NAIVE.Game(Nighthawks)
