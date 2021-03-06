class NAIVE.Actor
  velocity: 20
  target: null
  onTargetArrived: null
  width: 130
  height: 175
  position: null
  frame: 0
  currentWalkArea: null
  cssTransforms: []

  update: ->
    @frame += 1
    @cssTransforms = []
    if @target?
      if @position.distanceTo(@target) < @velocity
        @position = @target
        @target = null
        if @onTargetArrived?
          callback = @onTargetArrived
          @onTargetArrived = null
          callback()
      else
        @position = @position.pointBetween(@target, @velocity)
    @updateAnimation()
    @setPosition()

  setPosition: ->
    @e.css
      left: @position.x - (@width/2)
      top: @position.y - @height
      "z-index": @zIndex || 0
    #scale = @position.y / 450
    scale = @currentWalkArea.calculateScale(@position)
    @cssTransforms.push "scale(#{scale}, #{scale})"
    @e.css
      "-webkit-transform": @cssTransforms.join(" ")
      "-moz-transform": @cssTransforms.join(" ")
      "-ms-transform": @cssTransforms.join(" ")
      "transform": @cssTransforms.join(" ")

  setTarget: (point, callback) ->
    @target = point
    @onTargetArrived = callback

  goTo: (point, callback) ->
    # assumes that point is in a walkArea
    walkArea = game.findAreaForPoint(point)
    unless @currentWalkArea?
      console.log "lost track of the currentWalkArea, applying a new one"
      walkArea.onEntry(@)

    path = @currentWalkArea.findPath(walkArea)

    if path?
      if path.length == 0
        @setTarget point, callback
      else
        walkPath = (path, i) =>
          if connection = path[i]
            @setTarget connection.point, =>
              walkPath path, i + 1
              connection.walkArea.onEntry(@)
          else
            @setTarget point, callback
        walkPath(path, 0)

    else
      @say "No way I can get there"

  goCloseTo: (p, callback) ->
    closestPoint = game.findClosestPointInWalkingAreaForPoint(p)
    @goTo(closestPoint, callback)

  stop: ->
    @target = null
    @onTargetArrived = null

  say: (message, callback) ->
    textPosition = new NAIVE.P @position.x, @position.y - @height - 70
    game.showMessage(textPosition, message, "#f06", callback)

  constructor: ->
    @e = $(".actor")

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
        animation = "stan-walking-right"
        @cssTransforms.push "scale(-1, 1)"
        animationFrames = 6
    else
      animation = "stan-waiting"
      animationFrames = 4

    toBeRemoved = []
    toBeAdded   = []
    for i in [0..animationFrames]
      animationFrameName = "#{animation}-#{i}"
      if @frame % animationFrames == i
        toBeAdded.push animationFrameName
      else
        toBeRemoved.push animationFrameName
    @e.attr("class", "actor #{toBeAdded[0]}")
