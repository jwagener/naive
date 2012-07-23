window.front = new NAIVE.WalkArea
  name: "front"
  points: [
    new NAIVE.P(3, 599)
    new NAIVE.P(9, 428)
    new NAIVE.P(840, 597)
  ]

window.back = new NAIVE.WalkArea
  name: "back"
  points: [
    new NAIVE.P(9, 428)
    new NAIVE.P(327, 408)
    new NAIVE.P(336, 484)
  ]

window.barDoor = new NAIVE.WalkArea # outside of the screen
  name: "back"
  points: [
    new NAIVE.P(9, 428)
    new NAIVE.P(327, 408)
    new NAIVE.P(336, 484)
  ]

window.barEntry = new NAIVE.WalkArea
  name: "back"
  points: [
    new NAIVE.P(9, 428)
    new NAIVE.P(327, 408)
    new NAIVE.P(336, 484)
  ]

window.barBack = new NAIVE.WalkArea
  name: "back"
  points: [
    new NAIVE.P(9, 428)
    new NAIVE.P(327, 408)
    new NAIVE.P(336, 484)
  ]

NAIVE.WalkArea.connect(new NAIVE.P(159, 433), back, front)
NAIVE.WalkArea.connect(new NAIVE.P(851, 599), front, barDoor)
NAIVE.WalkArea.connect(new NAIVE.P(1035, 551), barDoor, barEntry)
NAIVE.WalkArea.connect(new NAIVE.P(475, 455), barEntry, barBack)

class window.Nighthawks extends NAIVE.Game
  title: "Nighthawks"
  backgrounds: ["/images/nighthawks.png"]
  walkAreas: [front, back, barDoor, barEntry, barBack]
