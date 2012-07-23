class NAIVE.Actor
  velocity: 10
  target: null
  width: 130
  height: 175
  position: null
  frame: 0
  update: ->
    @frame += 1

    @position = @position.pointBetween(@target, @velocity)
    @updateAnimation()
    @setPosition()

  setPosition: ->
    @e.css
      left: @position.x - (@width/2)
      top: @position.y - @height

  constructor: ->
    @e = $(".actor")
    @target  = new NAIVE.P(250, 550)
    @position = new NAIVE.P(-150, 550)

  updateAnimation: ->
    baseAnimation = "stan-walking-right"
    animationFrames = 6
    toBeRemoved = []
    toBeAdded   = []
    for i in [0..animationFrames]
      animationFrameName = "#{baseAnimation}-#{i}"
      if @frame % animationFrames == i
        toBeAdded.push animationFrameName
      else
        toBeRemoved.push animationFrameName
    @e.removeClass(toBeRemoved.join(" ")).addClass(toBeAdded.join(" "))
