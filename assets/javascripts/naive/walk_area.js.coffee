class NAIVE.WalkArea extends NAIVE.Area
  constructor: (options={}) ->
    super(options)
    @zIndex ||= 100
    @walkAreaConnections ||= []

  onClick: (point, game, actor) ->
    actor.goTo(point)
    #if @polygon.isPointWithin(actor.position)
    #  actor.target = point
    #else
    #  console.log("find path fucker")

  onEntry: (actor) ->
    console.log("onEntry", actor)
    actor.currentWalkArea = @
    actor.zIndex = @zIndex

  findPath: (toWalkarea, checkedWalkAreas=[], currentPath=[]) ->
    checkedWalkAreas.push @

    return currentPath if toWalkarea == @

    for walkAreaConnection in @walkAreaConnections
      walkArea = walkAreaConnection.walkArea
      branchPath = $.merge([], currentPath)
      branchPath.push walkAreaConnection
      if checkedWalkAreas.indexOf(walkArea) == -1 # walkArea not already tested
        if path = walkArea.findPath(toWalkarea, checkedWalkAreas, branchPath)
          return path
    null

NAIVE.WalkArea.connect = (point, walkArea1, walkArea2) ->
  walkArea1.walkAreaConnections.push
    walkArea: walkArea2
    point: point

  walkArea2.walkAreaConnections.push
    walkArea: walkArea1
    point: point
