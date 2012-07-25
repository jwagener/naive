class NAIVE.ItemArea extends NAIVE.Area
  constructor: (options) ->
    super(options)
    @onClick = options.onClick if options.onClick
    @sayColor = options.sayColor || "white"

  onClick: (p, game) ->
    game.actor.goCloseTo p, ->
      # NO OP

  say: (message, callback) ->
    point = @polygon.topCenterPoint()
    point.y -= 50
    point.x -= message.length * 10
    game.showMessage(point, message, @sayColor, callback)
