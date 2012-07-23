class NAIVE.P
  toString: -> "#{@x}, #{@y}"
  deg2rad: (d) -> d * Math.PI / 180
  rad2deg: (r) -> r / Math.PI * 180

  pointBetween: (point, distance) ->
    deg = Math.PI / 180.0
    angle = @angleFor(point)
    r = @deg2rad(angle - 90)
    x = Math.round(@x + distance * Math.cos(r))
    y = Math.round(@y + distance * Math.sin(r))
    newPoint = new NAIVE.P(x, y)

  distanceTo: (otherPoint) ->
    x = @x
    y = @y
    x0 = otherPoint.x
    y0 = otherPoint.y
    Math.sqrt((x -= x0) * x + (y -= y0) * y);

  angleFor: (otherPoint) ->
    @coordsToAngle(@x, @y, otherPoint.x, otherPoint.y)

  coordsToAngle: (x1, y1, x2, y2) ->
    (@rad2deg(Math.atan2(x2 - x1, y1 - y2)) + 360) % 360

  constructor: (x, y) ->
    @x = x
    @y = y