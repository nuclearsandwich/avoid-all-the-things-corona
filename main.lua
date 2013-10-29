-- # Avoid All the Things! #

local widget = require("widget")
local scoreboard = require("scoreboard")
local newObstacleTimerID, scoreIncrementTimerID
local score
local obstacleImages = { "icecream.png", "yarn.png", "penguin.png" }
local obstacles = {}
local topScores = scoreboard.newScoreboard()

local background = display.newImageRect("starsbg.jpg", display.contentWidth, display.contentHeight)
background:setReferencePoint(display.CenterReferencePoint)
background.x  = display.contentCenterX
background.y  = display.contentCenterY

local displayScoreboard = display.newText({
	text = "",
	x = 200,
	y = 200,
	font = native.systemFont,
	fontSize = 32,
})
displayScoreboard:setTextColor(255, 255, 255)

displayScoreboard.show = function(displayText, scores)
	local newText = "poop"
	for i = 1, #scores do
		newText = newText ..
			i .. ".     " .. scores[i].name .. "     " .. scores[i].score .. "\n"
	end
	displayText.text = newText
	displayText.isVisible = true
end

displayScoreboard.hide = function(displayText)
	displayText.isVisible = false
end

topScores.scores = {
	{name="Steven!", score=50},
	{name="Mike", score=30},
	{name="Joe", score=5},
	{name="Mickey", score=3},
	{name="Mickey", score=3},
}
topScores:save()

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

ship.collidedWith = function(ship, obstacle)
	if not obstacle then return false end

	local distanceX = ship.x - obstacle.x
	local distanceY = ship.y - obstacle.y

	local distance = math.sqrt(distanceX * distanceX + distanceY * distanceY)

	local collisionRadius = (ship.contentWidth / 4) + (obstacle.contentWidth / 2)

	if (distance < collisionRadius) then
		return true
	end
	return false
end

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
	local negativeOneOrOne = {1, -1}
	obstacle:setReferencePoint(display.CenterReferencePoint)
	obstacle.x = 50
	obstacle.y = 200
	obstacle.deltaX = math.random(5,10) * negativeOneOrOne[math.random(1,2)]
	obstacle.deltaY = math.random(5,10) * negativeOneOrOne[math.random(1,2)]
	obstacle.deltaAngle = 20
	obstacles[(#obstacles + 1)] = obstacle
end

local detectCollisions = function()
	obstacles:eachObstacle(function(obstacle)
		if ship:collidedWith(obstacle) then
			reset()
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

local startButton = widget.newButton({
	top = display.contentCenterY - 50, 
	left = display.contentCenterX - 100,
	label = "Start Game",
	width = 200,
	height = 100,
	onRelease = function(event)
		start()
	end,
})
startButton.show = function(button)
	button.isVisible = true
end
startButton.hide = function(button)
	button.isVisible = false
end

local displayScore = display.newText({
	text = "",
	x = 50,
	y = 50,
	font = native.systemFont,
	fontSize = 16,
})

displayScore:setTextColor(255, 255, 255)

local incrementScore = function()
	score = score + 1
	displayScore.text = score
end

start = function()
	score = 0
	displayScore.text = score
	startButton:hide()
	newObstacleTimerID = timer.performWithDelay(2000, newObstacle, 0)
	scoreIncrementTimerID = timer.performWithDelay(1000, incrementScore, 0)
	Runtime:addEventListener("enterFrame", eachFrame)
	ship:addEventListener("touch", ship.touch)
end

stop = function()
	timer.cancel(newObstacleTimerID)
	timer.cancel(scoreIncrementTimerID)
	Runtime:removeEventListener("enterFrame", eachFrame)
	ship:removeEventListener("touch", ship.touch)
end

reset = function()
	stop()
	obstacles:clearAll()
	ship.x = display.contentCenterX
	ship.y = display.contentCenterY
	startButton:show()
end	
