sinon = require "sinon"
LineCss  = require "../src/line-css"

describe "LineCss", ->
  pointA = {x: 10, y: 10}

  firstQuadrantPoint  = {x:  7, y:  6}
  secondQuadrantPoint = {x: 13, y:  6}
  thirdQuadrantPoint  = {x: 13, y: 14}
  fourthQuadrantPoint = {x:  7, y: 14}

  quadrantCornerPoints = [
    firstQuadrantPoint
    secondQuadrantPoint
    thirdQuadrantPoint
    fourthQuadrantPoint
  ]

  verticalAlignedPoints = [
    {x: 10, y:  6}
    {x: 10, y: 14}
  ]

  horizontalAlignedPoints = [
    {x:  7, y: 10}
    {x: 13, y: 10}
  ]

  describe "#_adjacentLength", ->
    it "returns the adjacent length", ->
      for pointB in quadrantCornerPoints
        line = new LineCss(pointA, pointB)
        line._adjacentLength().should.equal 3

      for pointB in verticalAlignedPoints
        line = new LineCss(pointA, pointB)
        line._adjacentLength().should.equal 0

      for pointB in horizontalAlignedPoints
        line = new LineCss(pointA, pointB)
        line._adjacentLength().should.equal 3

  describe "#_oppositeLength", ->
    it "returns the opposite length", ->
      for pointB in quadrantCornerPoints
        line = new LineCss(pointA, pointB)
        line._oppositeLength().should.equal 4

      for pointB in verticalAlignedPoints
        line = new LineCss(pointA, pointB)
        line._oppositeLength().should.equal 4

      for pointB in horizontalAlignedPoints
        line = new LineCss(pointA, pointB)
        line._oppositeLength().should.equal 0

  describe "#_hypotenuseLength", ->
    it "returns the hypotenuse length", ->
      for pointB in quadrantCornerPoints
        line = new LineCss(pointA, pointB)
        line._hypotenuseLength().should.equal 5

      for pointB in verticalAlignedPoints
        line = new LineCss(pointA, pointB)
        line._hypotenuseLength().should.equal 4

      for pointB in horizontalAlignedPoints
        line = new LineCss(pointA, pointB)
        line._hypotenuseLength().should.equal 3

  describe "#_rotationRadians", ->
    it "returns the rotation in radians", ->
      line = new LineCss(pointA, firstQuadrantPoint)
      line._rotationRadians().should.equal Math.atan(line._oppositeLength() / line._adjacentLength())

      line = new LineCss(pointA, secondQuadrantPoint)
      line._rotationRadians().should.equal -Math.atan(line._oppositeLength() / line._adjacentLength())

      line = new LineCss(pointA, thirdQuadrantPoint)
      line._rotationRadians().should.equal Math.atan(line._oppositeLength() / line._adjacentLength())

      line = new LineCss(pointA, fourthQuadrantPoint)
      line._rotationRadians().should.equal -Math.atan(line._oppositeLength() / line._adjacentLength())

      for pointB in horizontalAlignedPoints
        line = new LineCss(pointA, pointB)
        line._rotationRadians().should.equal 0

      for pointB in verticalAlignedPoints
        line = new LineCss(pointA, pointB)
        line._rotationRadians().should.equal Math.PI / 2

  describe "#_rotationDegrees", ->
    it "returns the rotation in degrees", ->
      line = new LineCss({x: 0, y:0}, {x: 1, y: 1})

      sinon.stub(line, "_rotationRadians").returns Math.PI
      line._rotationDegrees().should.equal 180

      line = new LineCss({x: 0, y:0}, {x: 1, y: 1})
      sinon.stub(line, "_rotationRadians").returns Math.PI / 2
      line._rotationDegrees().should.equal 90

      line = new LineCss({x: 0, y:0}, {x: 1, y: 1})
      sinon.stub(line, "_rotationRadians").returns -Math.PI / 4
      line._rotationDegrees().should.equal -45

  describe "#_x", ->
    it "returns the x co-ordinate for the rotated line", ->
      for pointB in verticalAlignedPoints
        line = new LineCss(pointA, pointB)
        line._x().should.equal 8

      for pointB in horizontalAlignedPoints
        line = new LineCss(pointA, pointB)
        line._x().should.equal if pointA.x < pointB.x then pointA.x else pointB.x

  describe "#_y", ->
    it "returns the y co-ordinate for the rotated line", ->
      for pointB in verticalAlignedPoints
        line = new LineCss(pointA, pointB, 4)
        line._y().should.equal if pointB.y < pointA.y then 6 else 10

      for pointB in horizontalAlignedPoints
        line = new LineCss(pointA, pointB, 4)
        line._y().should.equal 8

  describe "#schema", ->
    it "should return a line schema", ->
      line = new LineCss({x: 5, y: 5}, {x: 10, y: 10}, 4)

      sinon.stub(line, "_hypotenuseLength").returns 100.1
      sinon.stub(line, "_rotationDegrees").returns "degree_val"
      sinon.stub(line, "_y").returns "top_val"
      sinon.stub(line, "_x").returns "left_val"

      line.schema().should.eql
        width:   100
        height:  4
        degrees: "degree_val"
        top:     "top_val"
        left:    "left_val"
