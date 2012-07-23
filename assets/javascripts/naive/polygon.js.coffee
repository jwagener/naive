class NAIVE.Polygon
  points: []
  constructor: (options) ->
    @points = options.points

  isPointWithin: (point) ->
    @pointInPoly(point, @points)

  toCanvas: (ctx) ->
    ctx.fillStyle = 'rgba(200,0,0, 0.5)'
    ctx.beginPath()
    firstPoint = @points.shift()
    ctx.moveTo(firstPoint.x, firstPoint.y)
    for point in @points
      ctx.lineTo(point.x, point.y)
    ctx.closePath()
    ctx.fill()

  pointInPoly: (point,poly) ->
    segments = for pointA, index in poly
      pointB = poly[(index + 1) % poly.length]
      [pointA,pointB]
    intesected = (segment for segment in segments when @rayIntesectsSegment(point,segment))
    intesected.length % 2 != 0

  rayIntesectsSegment: (p,segment) ->
    [p1,p2] = segment
    [a,b] = if p1.y < p2.y
      [p1,p2]
    else
      [p2,p1]
    if p.y == b.y || p.y == a.y
      p.y += Number.MIN_VALUE

    if p.y > b.y || p.y < a.y
      false
    else if p.x > a.x && p.x > b.x
      false
    else if p.x < a.x && p.x < b.x
      true
    else
      mAB = (b.y - a.y) / (b.x - a.x)
      mAP = (p.y - a.y) / (p.x - a.x)
      mAP > mAB
