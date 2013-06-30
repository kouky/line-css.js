# LineCss

Draw arbitrary lines in 2D space with CSS.

A small JavaScript library that computes the CSS styles required to render a line of any stroke width between two arbitrary points.

See a [working example](http://jsfiddle.net/kouky/jHWHz/embedded/result/) on JSFiddle.

## Usage

One single API method is provided which takes three arguments.

    LineCss.forPointsWithStroke(pointA, pointB, stroke)

Arguments _pointA_ and _pointB_ represent the start and end points for the line on a cartesian plane, the _stroke_ argument denotes the width of the desired line in pixels.

		pointA = {x: 1, y: 1};
		pointA = {x: 30, y: 20};
		stroke = 4;

The _forPointsWithStroke_ method returns an object describing the CSS styles, including rotation in counter-clockwise degrees, required to render the line specified.

		{
			degrees: 45
			height: 4
			left: -5
			top: 14
			width: 41
		}

Use jQuery, Zepto or plain old JavaScript to decorate a block level absolutely positioned html element with the returned CSS styles to have the line rendered.

## Notes

This library was extracted from a html based game project I collaborated on with my friend and colleague [Josh Bassett](https://github.com/nullobject).