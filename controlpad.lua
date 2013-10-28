local ControlPad = {}

local controlPadFunctions = {
	whenUpPressed = function(controlpad, whenPressed)
		controlpad.up:addEventListener("touch", function(event)
			if event.phase == "began" then
				whenPressed()
			end
		end)
	end,

	whenDownPressed = function(controlpad, whenPressed)
		controlpad.down:addEventListener("touch", function(event)
			if event.phase == "began" then
				whenPressed()
			end
		end)
	end,

	whenLeftPressed = function(controlpad, whenPressed)
		controlpad.left:addEventListener("touch", function(event)
			if event.phase == "began" then
				whenPressed()
			end
		end)
	end,

	whenRightPressed = function(controlpad, whenPressed)
		controlpad.right:addEventListener("touch", function(event)
			if event.phase == "began" then
				whenPressed()
			end
		end)
	end,

	show = function(controlpad)
		controlpad.displayGroup.isVisible = true
	end,

	hide = function(controlpad)
		controlpad.displayGroup.isVisible = false
	end,
}

ControlPad.newControlPad = function(x, y, radius)
	local controlpad = {}
	controlpad.displayGroup = display.newGroup()

	controlpad.up = display.newRect(controlpad.displayGroup,
	radius / 2, 0,
	radius / 3, radius)
	controlpad.up:setFillColor(92, 92, 92)

	controlpad.down = display.newRect(controlpad.displayGroup,
	radius / 2, radius / 3,
	radius / 3, radius)
	controlpad.down:setFillColor(92, 92, 92)

	controlpad.left = display.newRect(controlpad.displayGroup,
	0, radius / 2,
	radius, radius / 3)
	controlpad.left:setFillColor(92, 92, 92)

	controlpad.right = display.newRect(controlpad.displayGroup,
	radius / 3, radius / 2,
	radius, radius / 3)
	controlpad.right:setFillColor(92, 92, 92)

	controlpad.show = controlPadFunctions.show
	controlpad.hide = controlPadFunctions.hide
	controlpad.whenUpPressed = controlPadFunctions.whenUpPressed
	controlpad.whenDownPressed = controlPadFunctions.whenDownPressed
	controlpad.whenRightPressed = controlPadFunctions.whenRightPressed
	controlpad.whenLeftPressed = controlPadFunctions.whenLeftPressed
	controlpad.displayGroup.x = x
	controlpad.displayGroup.y = y
	return controlpad 
end

return ControlPad
