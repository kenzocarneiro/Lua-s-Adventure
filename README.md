# Lua-s-Adventure
Lua's adventure is an action-RPG made with the LÖVE library of the Lua language.


## How to install the game
In order to play the game, you have to:
- Clone this repository in a local folder
- Install love: https://love2d.org/
- Launch love in the game folder using this syntax:
```
<love_executable_path> <game_folder>
```
For example, if your game is in the "lua_game" folder, and love is in your PATH, you can do:
```
love lua_game
```

More information is available here: https://love2d.org/wiki/Getting_Started


## Keybindings

*moving*
- z : go up
- s : go down
- q : go left
- d : go right
- (For now, the arrows are still supported. But it may be deleted in a future version)

*shooting*
- SPACE : shoot

*items*
- a : consume potion
- i : inventory (not yet implemented)

*miscellanenous*
- p : parameters
- l : lose life
- m : regain life
- LSHIFT : display hitboxes
- LCTRL : display item collect radius