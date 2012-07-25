window.windowItemArea = new NAIVE.ItemArea
  points: [
    new NAIVE.P(49, 199)
    new NAIVE.P(165, 205)
    new NAIVE.P(165, 360)
    new NAIVE.P(50, 361)
  ]

  onClick: (p, game) ->
    game.actor.goCloseTo p, ->
      game.actor.say "There is nothing in there..."

$ ->
  game.itemAreas.push windowItemArea
