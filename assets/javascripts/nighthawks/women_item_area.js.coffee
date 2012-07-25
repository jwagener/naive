window.womenItemArea = new NAIVE.ItemArea
  points: [
    new NAIVE.P(807, 366)
    new NAIVE.P(823, 298)
    new NAIVE.P(836, 297)
    new NAIVE.P(844, 363)
  ]

  closePoint: new NAIVE.P(873, 436)
  sayColor: "red"
  onClick: (p, game) ->
    game.actor.goCloseTo @closePoint, =>
      @say "Hey boy..", =>
        game.actor.say "Hola."

$ ->
  game.itemAreas.push womenItemArea
