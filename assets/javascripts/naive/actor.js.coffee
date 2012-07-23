class NAIVE.Actor
  velocity: 10
  target: null
  width: 130
  height: 175
  position: null
  frame: 0
  update: ->
    @frame += 1
    if @target?
      if @position.distanceTo(@target) < @velocity
        @position = @target
        @target = null
        console.log "arrived"
      else
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
    if @target?
      angle = @position.angleFor(@target)
      if angle > 315 || angle < 45
        animation = "stan-walking-back"
        animationFrames = 5
      else if angle > 45 && angle < 135
        animation = "stan-walking-right"
        animationFrames = 6
      else if angle > 135 && angle < 225
        animation = "stan-walking-front"
        animationFrames = 6
      else if angle > 225 && angle < 315
        animation = "stan-walking-left"
        animationFrames = 6
    else
      animation = "stan-waiting"
      animationFrames = 2

    toBeRemoved = []
    toBeAdded   = []
    for i in [0..animationFrames]
      animationFrameName = "#{animation}-#{i}"
      if @frame % animationFrames == i
        toBeAdded.push animationFrameName
      else
        toBeRemoved.push animationFrameName
    #@e.removeClass(toBeRemoved.join(" ")).addClass(toBeAdded.join(" "))
    @e.attr("class", "actor #{toBeAdded[0]}")
