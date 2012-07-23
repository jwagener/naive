class NAIVE.WalkArea extends NAIVE.Area
  onClick: (point, game, actor) ->
    if @polygon.isPointWithin(actor.position)
      actor.target = point
      console.log("same")
    else
      console.log("find path fucker")

