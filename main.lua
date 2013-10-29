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

ship.collidedWith = function(ship, obstacle)
	if not obstacle then return false end

	local distanceX = ship.x - obstacle.x
	local distanceY = ship.y - obstacle.y

	local distance = math.sqrt(distanceX * distanceX + distanceY * distanceY)

	local collisionRadius = (ship.contentWidth / 2) + (obstacle.contentWidth / 2)

	if (distance < collisionRadius) then
		return true
	end
	return false
end

local obstacleImages = { "icecream.png", "yarn.png", "penguin.png" }
local obstacles = {}

obstacles.eachObstacle = function(obstacles, doEach)
	for i = 1, #obstacles do
		doEach(obstacles[i])
	end
end

obstacles.clearAll = function(obstacles)
	for i = 1, #obstacles do
		display.remove(obstacles[i])
		obstacles[i] = nil
	end
end

local newObstacle = function()
	local obstacle = display.newImageRect(obstacleImages[math.random(1, #obstacleImages)], 50, 50)
	obstacle:setReferencePoint(display.CenterReferencePoint)
	obstacle.x = 50
	obstacle.y = 200
	obstacle.deltaX = math.random(5,10)
	obstacle.deltaY = math.random(5,10)
	obstacle.deltaAngle = 20
	obstacles[(#obstacles + 1)] = obstacle
end

local newObstacleTimerID = timer.performWithDelay(2000, newObstacle, 0)

local resetGame = function()
	obstacles:clearAll()
	ship.x = display.contentCenterX
	ship.y = display.contentCenterY
end

local detectCollisions = function()
	obstacles:eachObstacle(function(obstacle)
		if ship:collidedWith(obstacle) then
			resetGame()
			local r = math.random(0, 255)
			local g = math.random(0, 255)
			local b = math.random(0, 255)
		end
	end)
end

local eachFrame = function()
	obstacles:eachObstacle(function(o)
		if not o then return end
		if (o.x + o.deltaX > display.contentWidth) or (o.x + o.deltaX < 0) then
			o.deltaX = -1 * o.deltaX
			o.deltaAngle = -1 * o.deltaAngle
		end

		if (o.y + o.deltaY > display.contentHeight) or (o.y + o.deltaY < 0) then
			o.deltaY = -1 * o.deltaY
			o.deltaAngle = -1 * o.deltaAngle
		end

		o.x =  o.x + o.deltaX
		o.y =  o.y + o.deltaY
		o:rotate(o.deltaAngle)

		detectCollisions()
	end)
end
Runtime:addEventListener("enterFrame", eachFrame)


