class Nighthawks.BarEntryWalkArea extends NAIVE.WalkArea
  name: "back"
  points: [
    new NAIVE.P(1046, 585)
    new NAIVE.P(1047, 547)
    new NAIVE.P(503, 470)
    new NAIVE.P(397, 484)
  ]
  zIndex: 150
  onEntry: (actor) ->
    super(actor)
