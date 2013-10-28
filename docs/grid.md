# Grid

Documentation for the CoderDojoSV Grid library

## Requiring the grid module

To use the grid library, it must be required somewhere in your code. To do
this you use the require function. Make sure you save the result of
require to a local variable otherwise you won't be able to use it!

```lua
local grid = require("grid")
```

### Module Functions

* `newGrid()` Create a new Grid object
* `newGridRow()` Create a new grid row (for internal use only)
* `newGridSquare()` Create a new grid square

## Creating a grid with newGrid()

Grids are created by specifying the size of the grid in x and y
coordinates as well as the total width of the grid in pixels. A new grid object
is created with all of the grid squares initialized with invisible
`displayObjects`.

		grid.newGrid(xSquares, ySquares, totalWidth)

#### Parameters

* __xSquares__ the total number of squares across; the number of columns
* __ySquares__ the total number of squares down; the number of rows
* __totalWidth__ the total width of the grid on the screen

#### Examples

###### Create a 5x5 grid where each square is 100 pixels in size

```lua
local grid = require("grid")
local mygrid = grid.newGrid(5, 5, 500)
```

###### Create the grid from robotfindskitten

```lua
local screenWidth, margins
local grid = require("grid")
local mygrid = grid.newGrid(10, 7, screenWidth - margins)
```

## Grid objects

### Fields

* `xSquares` The number of x squares or columns
* `ySquares` The number of y squares or rows
* `totalWidth` The total width in display pixels of the grid
* `squareSize` The size of each grid square in display pixels
* `displayGroup` The display group containing the grid

### Methods

* `[y][x]` Access an individual grid square by coordinate
* `setLocation(x, y)` Update the location of the entire grid
* `eachSquare(doEach)` Iterator function for accessing each grid square
* `show()`
* `hide()`

### Accessing a grid square

Grid squares are indexed first by their *y* value then by their *x* value.
It is possible to provide only the *y* coordinate and receive a grid row
however this isn't very useful.

		grid[y][x]

#### Parameters

* __y__ The *y* coordinate of a grid square
* __x__ The *x* coordinate of a grid square

#### Examples

###### Checking a grid square for the presence of obstacles

```lua
local thisX, thisY = character.x, character.y
if grid[thisY + 1][thisX].obstacle then
	print("cannot move down")
else
	print("move down!")
end	
```

###### Setting the color of a specific Grid square.

```lua
grid[0][1].displayObject:setFillColor(0, 0, 255, 255)
```

### Setting the grid's location

		grid:setLocation(x, y)

#### Parameters

* `x` The x display pixel coordinate of the top left corner of the grid
* `y` The y display pixel coordinate of the top left corner of the grid

#### Examples

###### Apply a top and left margin to the grid

```lua
local myGrid = grid.newGrid(5, 5, 500)
local topMargin = 100
local leftMargin = 80
myGrid:setLocation(leftMargin, topMargin)
```

### Iterating over all grid squares

		grid:eachSquare(doEach)

#### Parameters

* `doEach` A *function* with a single parameter that will be run on each
individual square.

#### Examples

###### Checkerboard

```lua
local checkerboard = grid.newGrid(8, 8, 700)
checkerboard:eachSquare(function(gridSquare)
	-- Tests if the square is "even".
	if (gridSquare.x + gridSquare.y) % 2 == 0 then
		gridSquare.displayObject:setFillColor(255, 255, 255, 255)
	else
		gridSquare.displayObject:setFillColor(0, 0, 0, 255)
	end
end)
```

###### Add an event listener for touches on each square

```lua
myGrid = grid.newGrid(5, 5, 500)
local addTouchListener = function(gridSquare)
	local touch = function
		if event.phase == "began" then
			print("Touched square at x: " .. gridSquare.x .. " y: " .. gridSquare.y)
		end
	end

	gridSquare.displayObject:addEventListener("touch", touch)
end

myGrid:eachSquare(addTouchListener)
```

### Showing and hiding the grid

Grids can be shown or hidden on screen using the `show()` and `hide()` methods.

		grid:show()
		grid:hide()

#### Examples

###### Hide the maze until the player hits the startbutton

```lua
local grid = require("grid")
local maze = grid.newGrid(10, 7, 1000)
maze:hide() -- Hidden when created

start = function()
	stopwatch:start()
	controls:show()
	startButton:hide()

	maze:show() -- Shown at the start of the game
end
```

###### Going from level one to level two.

```lua
local grid = require("grid")
local levelone = grid.newGrid(5, 5, 500)
local leveltwo = grid.newGrid(5, 5, 500)

levelone.finish = levelone[3][4]
leveltwo.start = leveltwo[0][0]

if player.gridSquare == levelone.finish
	levelone:hide()
	leveltwo:show()
	player:enter(leveltwo.start)
```
## GridSquare objects

### Fields

* `x`
* `y`
* `displayObject`
* `grid`

### Methods

* `left`
* `right`
* `above`
* `below`

