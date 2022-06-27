# Lua-s-Adventure
Lua's adventure is an action-RPG made with the LÖVE library in Lua.

Made by:
- Lucien Audebert
- Nicolas Bédrunes
- Kenzo Carneiro
- Tristan Claudé
- Rose Thieullet.

Special thanks to:
- Our teacher and tutor for this project, M. Xavier Bultel.
- Our reviewer, M. Ahmad Abdallah.
- M. Pascal Berthomé for approving the subject of this project.

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

*Moving:*
- z : go up
- s : go down
- q : go left
- d : go right
- (For now, the arrows are still supported. But it may be deleted in a future version)

*Shooting:*
- SPACE : shoot

*Items:*
- a : consume potion
- i : inventory (not yet implemented)

*Miscellanenous:*
- p : parameters
- l : lose life
- m : regain life
- LSHIFT : display hitboxes
- LCTRL : display item collect radius