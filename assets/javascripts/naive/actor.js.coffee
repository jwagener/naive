class NAIVE.Actor
  velocity: 20
  target: null
  onTargetArrived: null
  width: 130
  height: 175
  position: null
  frame: 0
  currentWalkArea: null

  update: ->
    @frame += 1
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

    scale = @position.y / 450
    #@e.css
    #  "-webkit-transform": "scale(#{scale}, #{scale})"

  setTarget: (point, callback) ->
    @target = point
    @onTargetArrived = callback

  goTo: (point, callback) ->
    # assumes that point is in a walkArea
    walkArea = game.findAreaForPoint(point)
    unless @currentWalkArea?
      console.log "lost track of the currentWalkArea, guessing a new one"
      @currentWalkArea = walkArea  
    path = @currentWalkArea.findPath(walkArea)

    if path?
      if path.length == 0
        @setTarget point, callback
      else
        walkPath = (path, i) =>
          console.log "walkPath segment", i, path
          if connection = path[i]
            @setTarget connection.point, =>
              console.log "walkPath segment point reached", connection.walkArea
              connection.walkArea.onEntry(@)
              walkPath path, i + 1
          else
            console.log "Going to the original destination"
            @setTarget point, callback
        walkPath(path, 0)

    else
      @say "No way I can get there"

  say: (message) ->
    console.log message

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
