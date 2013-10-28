-- # Coder Dojo Corona Game Starter Kit #

-- This is where your code for the game goes! You can use any of the libraries
-- we created during class by using the `require` function.

local ship = display.newImageRect("ship.png", 100, 100)
ship:setReferencePoint(display.CenterReferencePoint)

ship.x = display.contentCenterX
ship.y = display.contentCenterY

ship.touch = function(event)
	if event.phase == "began" then
		ship.onTheMove = true
	elseif event.phase == "moved" and ship.onTheMove then
		ship.x = event.x
		ship.y = event.y
	elseif event.phase == "ended" then
		ship.x = event.x
		ship.y = event.y
		ship.onTheMove = nil
	end
end

ship:addEventListener("touch", ship.touch)

local obstacleImages = { "icecream.png", "yarn.png", "penguin.png" }
local obstacles = {}

local newObstacle = function()
	local obstacle = display.newImageRect(obstacleImages[math.random(1, #obstacleImages)], 50, 50)
	obstacle:setReferencePoint(display.CenterReferencePoint)
	obstacle.x = 50
	obstacle.y = 200
	obstacle.deltaX = math.random(5,10)
	obstacle.deltaY = math.random(5,10)
	obstacles[(#obstacles + 1)] = obstacle
end

local newObstacleTimer = timer.performWithDelay(2000, newObstacle, 3)

local eachFrame = function()
	for i = 1, #obstacles do
		local o = obstacles[i]
		if (o.x + o.deltaX > display.contentWidth) or (o.x + o.deltaX < 0) then
			o.deltaX = -1 * o.deltaX
		end

		if (o.y + o.deltaY > display.contentHeight) or (o.y + o.deltaY < 0) then
			o.deltaY = -1 * o.deltaY
		end

		o.x =  o.x + o.deltaX
		o.y =  o.y + o.deltaY
	end
end
Runtime:addEventListener("enterFrame", eachFrame)
