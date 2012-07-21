//= require_tree ./vendor
//= require_self
//= require nighthawks

window.NAIVE =
  frame: 0
  initialize: (game) ->
    console.log("hi", game)
    window.setInterval NAIVE.runLoop, 250

    @initializeDebug()


  initializeDebug: ->
    canvas = $("")
    $(".canvas").live "click", (e) ->
      e.preventDefault()
      x = e.offsetX
      y = e.offsetY
      console.log "Debug: #{x}, #{y}"

  runLoop: () =>
    #@frame = @frame + 1 % 8
    #console.log("running", @frame)
    $("body").toggleClass("frame1")

window.NAIVE.P = (x, y) ->
  @x = x
  @y = y

$ ->
  NAIVE.initialize(Nighthawks)