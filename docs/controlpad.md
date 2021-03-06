# ControlPad

A four way directional control pad for games.

## Requiring the module

To use the module, it must be required somewhere in your code. To do
this you use the require function. Make sure you save the result of
require to a local variable otherwise you won't be able to use it!

```lua
local controlpad = require("controlpad")
```
## Module functions

* `newControlPad()` Create a new ControlPad object

### Creating the control pad

		controlpad.newControlPad(x, y, radius)

#### Parameters

* `x` The pixel display x coordinate of the center of the control pad
* `y` The pixel display y coordinate of the center of the control pad
* `radius` The radius in display pixels of the control pad circle

#### Examples

###### Creating a control pad

```lua
local controlpad = require("controlpad")
local myControls = controlpad.newControlPad(100, 500, 100)
```

## ControlPad object

### Fields

* `displayGroup` The display group containing the graphics for the
control pad

### Methods

* `whenUpPressed()` The function called when up is pressed
* `whenDownPressed()` The function called when down is pressed
* `whenLeftPressed()` The function called when left is pressed
* `whenRightPressed()` The function called when right is pressed
* `show()` Show the control pad on the screen
* `hide()` Hide the control pad from the screen

