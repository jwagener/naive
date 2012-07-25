class Nighthawks.BarEntryWalkArea extends NAIVE.WalkArea
  name: "back"
  points: [
    new NAIVE.P(1046, 585)
    new NAIVE.P(1047, 547)
    new NAIVE.P(503, 470)
    new NAIVE.P(397, 484)
  ]

  minY: 470
  maxY: 585
  minDepth: 1.1
  maxDepth: 1.3
  zIndex: 150

  onEntry: (actor) ->
    if game.state.convincedBarman
      super(actor)
    else if game.state.sawBarman
      game.state.convincedBarman = true
      barmanItemArea.say "What do you want? We are still closed!", ->
        actor.say "But I really need a drink!", ->
          barmanItemArea.say "Well, just this time. Here you go."
      super(actor)

      game.actor.goCloseTo barmanItemArea.closePoint
    else
      game.state.sawBarman = true
      barmanItemArea.say("We're closed already. Get out!")
      window.setTimeout (->
        p = new NAIVE.P(640, 568)
        actor.goTo p, ->
          actor.say("Well, it doesn't seem to be closed..")
      ), 800
