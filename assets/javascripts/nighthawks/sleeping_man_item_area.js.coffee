window.sleepingManItemArea = new NAIVE.ItemArea
  points: [
    new NAIVE.P(567, 411)
    new NAIVE.P(605, 296)
    new NAIVE.P(637, 409)
  ]

  closePoint: new NAIVE.P(534, 446)
  sayColor: "grey"

  onClick: (p, game) ->
    game.actor.goCloseTo @closePoint, =>
      @say "Zzzzzz, Zzzzzz", =>
        game.actor.say "Hmm, he seems to be sleeping"

$ ->
  game.itemAreas.push sleepingManItemArea
