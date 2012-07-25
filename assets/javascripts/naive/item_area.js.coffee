class NAIVE.ItemArea extends NAIVE.Area
  constructor: (options) ->
    super(options)
    @onClick = options.onClick if options.onClick
    @closePoint = options.closePoint
    @sayColor = options.sayColor || "white"

  onClick: (p, game) ->
    game.actor.goCloseTo p, ->
      # NO OP

  say: (message, callback) ->
    point = @polygon.topCenterPoint()
    point.y -= 70
    game.showMessage(point, message, @sayColor, callback)
