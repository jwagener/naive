window.cigManItemArea = new NAIVE.ItemArea
  points: [
    new NAIVE.P(733, 364)
    new NAIVE.P(803, 367)
    new NAIVE.P(793, 296)
    new NAIVE.P(750, 298)
  ]

  closePoint: new NAIVE.P(706, 408)
  sayColor: "blue"

  onClick: (p, game) ->
    game.actor.goCloseTo @closePoint, =>
      game.actor.say "Hey can I borrow a cig?", =>
        @say "Nope."

$ ->
  game.itemAreas.push cigManItemArea
