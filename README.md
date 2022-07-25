# Lua-s-Adventure
Lua's Adventure is an action-RPG made with the LÖVE library in Lua.
This is a school project carried out in our 3rd year of the Computer Security and Technologies section at INSA Centre Val de Loire.

![Lua's Adventure - Header Image](https://user-images.githubusercontent.com/90707620/180852841-b63e48f1-4cd0-4a42-b9c7-26b3178d78f0.png)

Presentation video - Trailer (in French): https://www.youtube.com/watch?v=_Kj-pnStFts

Made by:
- Lucien Audebert
- Nicolas Bédrunes
- Kenzo Carneiro
- Tristan Claudé
- Rose Thieullet

Special thanks to:
- Our teacher and tutor for this project, Mr. Xavier Bultel.
- Our reviewer, Mr. Ahmad Abdallah.
- Mr. Pascal Berthomé for approving the subject of this project.

## How to install the game
In order to play the game, you have multiple solutions:
- If you're on Windows:
  1) Download the .zip corresponding to your architecture (64 bits or 32 bits) here: https://github.com/kenzo6c/Lua-s-Adventure/releases
  2) Launch the .exe file
  3) Note: Your antivirus may have a problem with the dll files. These dll files come from the love installation, you can try with the dll from yours, or you can use the following method.
- If you're on another OS (or if your antivirus doesn't like the dll files):
  1) Download and install love: https://love2d.org/
  2) Put love in your PATH or note its location
  3) Download the .love file from the latest release: https://github.com/kenzo6c/Lua-s-Adventure/releases
  4) launch the .love file with love using this syntax in a terminal:
```
<love_executable_path> LuaAventure.love
```
If love is in your PATH, you can do:
```
love LuaAventure.love
```

- You can also:
  1) Clone this repository in a local folder
  2) Install love: https://love2d.org/
  3) Launch love in the game folder using this syntax:
```
<love_executable_path> <game_folder>
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
