# Character

Characters can be either player controlled or computer controlled. They're meant
to work with the [grid](grid.md) module.

## Requiring the module

To use the module, it must be required somewhere in your code. To do
this you use the require function. Make sure you save the result of
require to a local variable otherwise you won't be able to use it!

```lua
local character = require("character")
```

## Module Functions

* `newCharacter` Create a new character object

## Creating a character with newCharacter()

Creates a new character from an image name for use on a grid.

		character.newCharacter(imageName)

#### Parameters

* __imageName__ The name of the image to use for the character's on screen
	representation.

#### Examples

## Character objects

### Fields

* `gridSquare` The grid square the character is currently in or nil if
	they're off of the map
* `displayObject` The Corona ImageRect that displays the character

### Methods

* `enter(gridSquare)` Moves the character into the given grid square
* `show()` Makes the character visible
* `hide()` Hides the character from view

### Moving into grid squares with enter()

		char:enter(gridSquare)

#### Parameters

* `gridSquare` The specific GridSquare object to move the character into

#### Examples

###### Move the player into the first square of the grid

```lua
local character = require("character")
local player = char.newCharacter("runner.png")
player:enter(somegrid[0][0])
```

###### Move an enemy towards the player each turn

```lua
local character = require("character")
local enemy = character.newCharacter("badguy.png")
function enemyTurn()
	if enemy.gridSquare.x > player.gridSquare.x then
		enemy:enter(enemy.gridSquare:left())
	elseif enemy.gridSquare.x < player.gridSquare.x then
		enemy:enter(enemy.gridSquare:right())
	elseif enemy.gridSquare.y > player.gridSquare.y then
		enemy:enter(enemy.gridSquare:above())
	elseif enemy.gridSquare.y < player.gridSquare.y then
		enemy:enter(enemy.gridSquare:below())
	else
		print("Captured the player!")
	end
```

### Controlling visibility of the character with show() and hide()

		char:show()
		char:hide()

#### Examples

###### Hide an enemy when they are behind an obstacle

```lua
enemyCharacter:enter(enemyCharacter.gridSquare:left())

if enemyCharacter.gridSquare.obstacle then
	enemyCharacter:hide()
end
```

###### Reveal hidden enemies after a certain number of turns

```lua
if numberOfTurns > 5 then
	enemyOne:show()
	enemyTwo:show()
end
```
