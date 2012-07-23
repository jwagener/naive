class NAIVE.Area
  constructor: (options) ->
    @polygon = options.polygon if options.polygon?
    if options.points
      @polygon = new NAIVE.Polygon
        points: options.points

