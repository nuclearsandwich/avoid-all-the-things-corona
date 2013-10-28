local gridSquareFunctions = {
	left = function(gridSquare)
		if gridSquare.x == 0 then
			return gridSquare
		else
			return gridSquare.grid[gridSquare.y][gridSquare.x - 1]
		end
	end,

	right = function(gridSquare)
		if gridSquare.x + 1 == gridSquare.grid.xSquares then
			return gridSquare
		else
			return gridSquare.grid[gridSquare.y][gridSquare.x + 1]
		end
	end,

	above = function(gridSquare)
		if gridSquare.y == 0 then
			return gridSquare
		else
			return gridSquare.grid[gridSquare.y - 1][gridSquare.x]
		end
	end,

	below = function(gridSquare)
		if gridSquare.y + 1 == gridSquare.grid.ySquares then
			return gridSquare
		else
			return gridSquare.grid[gridSquare.y + 1][gridSquare.x]
		end
	end,
}

local gridFunctions = {
	eachSquare = function(grid, doEach)
		for y = 0, grid.ySquares - 1 do
			for x = 0, grid.xSquares - 1 do
				doEach(grid[y][x])
			end
		end

		return grid
	end,

	setLocation = function(grid, x, y)
		grid.displayGroup.x = x
		grid.displayGroup.y = y
		return grid
	end,

	show = function(grid)
		grid.displayGroup.isVisible = true
	end,

	hide = function(grid)
		grid.displayGroup.isVisible = false
	end,
}

local Grid = {}

Grid.newGridRow = function(y)
	return { y = y }
end

Grid.newGridSquare = function(grid, y, x)
	local gridSquare = {}
	gridSquare.y = y
	gridSquare.x = x

	local square = display.newRect(grid.displayGroup,
		grid.squareSize * x, grid.squareSize * y,
		grid.squareSize, grid.squareSize)
	gridSquare.displayObject = square
	gridSquare.left = gridSquareFunctions.left
	gridSquare.right = gridSquareFunctions.right
	gridSquare.above = gridSquareFunctions.above
	gridSquare.below = gridSquareFunctions.below
	gridSquare.grid = grid
	return gridSquare
end

Grid.newGrid = function(xSquares, ySquares, totalWidth)
	-- Initialize the grid object
	local grid = {}
	grid.xSquares = xSquares
	grid.ySquares = ySquares
	grid.totalWidth = totalWidth
	grid.squareSize = totalWidth / xSquares

	grid.displayGroup = display.newGroup()

	for y = 0, ySquares - 1 do
		grid[y] = Grid.newGridRow(y)
		for x = 0, xSquares - 1 do
			grid[y][x] = Grid.newGridSquare(grid, y, x)
		end
	end

	grid.eachSquare = gridFunctions.eachSquare
	grid.setLocation = gridFunctions.setLocation
	grid.show = gridFunctions.show
	grid.hide = gridFunctions.hide

	return grid
end

return Grid
