class LineCss
  @forPointsWithStroke: (pointA, pointB, stroke) ->
    a = new LineCss(pointA, pointB, stroke)
    a.schema()

  constructor: (@pointA, @pointB, @stroke = 1) ->

  schema: ->
    left:    @_x()
    top:     @_y()
    width:   Math.round(@_hypotenuseLength())
    height:  @stroke
    degrees: @_rotationDegrees()

  _x: ->
    offset = Math.round(Math.abs((@_hypotenuseLength() - @_adjacentLength()) / 2))
    if @pointB.x <= @pointA.x
      @pointB.x - offset
    else
      @pointA.x - offset

  _y: ->
    offset =  Math.round((-1 * @_oppositeLength() / 2) - (@stroke / 2))
    if @pointB.y <= @pointA.y
      @pointA.y + offset
    else
      @pointB.y + offset

  _rotationRadians: ->
    radians = => Math.atan(@_oppositeLength() / @_adjacentLength())
    if @pointB.x < @pointA.x and @pointB.y < @pointA.y
      radians()
    else if @pointB.x > @pointA.x and @pointB.y > @pointA.y
      radians()
    else if @_adjacentLength() is 0
      Math.PI / 2
    else
      -radians()

  _rotationDegrees: -> @_rotationRadians() * 180 / Math.PI

  _adjacentLength: -> Math.abs(@pointA.x - @pointB.x)

  _oppositeLength: -> Math.abs(@pointA.y - @pointB.y)

  _hypotenuseLength: ->
    Math.sqrt(
      Math.pow(@_adjacentLength(), 2) +
      Math.pow(@_oppositeLength(), 2)
    )

if typeof module isnt 'undefined' and typeof module.exports isnt 'undefined'
  module.exports = LineCss
else
  if typeof define is'function' and define.amd
    define [], -> LineCss
  else
    window.LineCss = LineCss
