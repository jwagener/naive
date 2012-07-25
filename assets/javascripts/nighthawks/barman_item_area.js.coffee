window.barmanItemArea = new NAIVE.ItemArea
  points: [
    new NAIVE.P(883, 319)
    new NAIVE.P(887, 384)
    new NAIVE.P(968, 390)
    new NAIVE.P(910, 324)
  ]

  closePoint: new NAIVE.P(744, 489)
  sayColor: "white"
  onClick: (p, game) ->
    game.actor.goCloseTo @closePoint, =>
      @say "Another round?", =>
        game.actor.say "Yeah!", =>
          @say "Here you go...", =>
            game.actor.say "Thanks, barman!"

$ ->
  game.itemAreas.push barmanItemArea
