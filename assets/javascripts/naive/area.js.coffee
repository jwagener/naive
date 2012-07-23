class NAIVE.Area
  constructor: (options) ->
    @polygon = options.polygon if options.polygon?
    if points = (options.points || @points)
      @polygon = new NAIVE.Polygon
        points: points

