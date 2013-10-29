local json = require("json")
json.decodeFile = function (filepath)
	local file = io.open(filepath, "r")
	if file then
		local contents = file:read("*a")
		return json.decode(contents)
	else
		return {}
	end
end

local Scoreboard = {}

local fileExists = function(filename)
	local path = system.pathForFile(filename, system.DocumentsDirectory)
	local handle = io.open(path)
	if handle ~= nil then
		handle:close()
		return true
	else
		return false
	end
end

local scoreboardFunctions = {
	save = function(scoreboard)
		local jsonScores = json.encode(scoreboard.scores)
		local filehandle = io.open(scoreboard.scoreFileName, "w")
		filehandle:write(jsonScores)
		filehandle:close()
	end,

	load = function(scoreboard)
		if fileExists(scoreboard.scoreFileName) then
			scoreboard.scores = json.decodeFile(scoreboard.scoreFileName)
		else
			scoreboard.scores = {}
		end
	end,
}

Scoreboard.newScoreboard = function()
	local scoreboard = {}
	scoreboard.scoreFileName = "scoreboard.json"
	scoreboard.load = scoreboardFunctions.load
	scoreboard.save = scoreboardFunctions.save
	scoreboard:load()
	return scoreboard
end

return Scoreboard
