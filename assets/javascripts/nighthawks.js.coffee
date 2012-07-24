//= require_self
//= require_tree ./nighthawks




class window.Nighthawks extends NAIVE.Game
  title: "Nighthawks"
  width: 1097
  height: 600

$ ->
  window.back     = new Nighthawks.BackWalkArea()
  window.front    = new Nighthawks.FrontWalkArea()
  window.barBack  = new Nighthawks.BarBackWalkArea()
  window.barDoor  = new Nighthawks.BarDoorWalkArea()
  window.barEntry = new Nighthawks.BarEntryWalkArea()
  
  NAIVE.WalkArea.connect(new NAIVE.P(187, 463), back, front)
  NAIVE.WalkArea.connect(new NAIVE.P(1100, 610), front, barDoor)
  NAIVE.WalkArea.connect(new NAIVE.P(1100, 500), barDoor, barEntry)
  NAIVE.WalkArea.connect(new NAIVE.P(475, 455), barEntry, barBack)

  window.game = new Nighthawks
    walkAreas: [front, back, barDoor, barEntry, barBack]

  game.actor.goTo new NAIVE.P(250, 550), ->
    game.actor.say "Howdie, I'm Stan!", ->
      game.actor.say "I need a drink and a cigarette!"
