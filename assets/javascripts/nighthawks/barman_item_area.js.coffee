window.barmanItemArea = new NAIVE.ItemArea
  points: [
    new NAIVE.P(883, 319)
    new NAIVE.P(887, 384)
    new NAIVE.P(968, 390)
    new NAIVE.P(910, 324)
  ]

  onClick: (p, game) ->
    game.actor.goCloseTo p, ->
      game.actor.say "Bla. Get out!"

$ ->
  game.itemAreas.push barmanItemArea




