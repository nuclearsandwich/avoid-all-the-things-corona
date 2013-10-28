local Character = {}
local reparentCharacter = function(character, grid)
	if character.displayObject then
		character.displayObject.parent:remove(character.displayObject)
		character.displayObject = nil
	end
	character.displayObject = display.newImageRect(grid.displayGroup,
		character.imageName, grid.squareSize, grid.squareSize)
end

local characterFunctions = {
	enter = function(character, gridSquare)
		if character.gridSquare == nil or character.gridSquare.grid ~= gridSquare.grid then
			reparentCharacter(character, gridSquare.grid)
		end
		if type(character.canEnter) == "function" and not character:canEnter(gridSquare) then
			return
		end

		character.gridSquare = gridSquare
		character.displayObject.x = gridSquare.displayObject.x
		character.displayObject.y = gridSquare.displayObject.y

		return character
	end,

	show = function(character)
		if character.displayObject then
			character.displayObject.isVisible = true
		end
	end,

	hide = function(character)
		if character.displayObject then
			character.displayObject.isVisible = false
		end
	end,
}

Character.newCharacter = function(imageName)
	local character = {}
	character.imageName = imageName
	character.enter = characterFunctions.enter
	character.show = characterFunctions.show
	character.hide = characterFunctions.hide
	return character
end

return Character
