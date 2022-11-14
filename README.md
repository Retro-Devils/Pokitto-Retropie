# Pokitto-Retropie

A simple installer for Pokitto handheld on Retropie.

# Installer Info:

          Version:          1.02

          Last Update:      11/13/22
          
# Emu Info:

          Creator:         FManga 
          
          Github Link:     https://github.com/felipemanga/PokittoEmu

          Version:         1.03 

          Last Update:     11/11/22



# FAQ

Whats game extensions? 

- .bin , .BIN , .pop & .POP

Why make this at all? 

- Someone asked & more systems the better . 

Why is the screen small?

- The emulator has a built in resolution. Lower Retropie settings to make biggeron your screen lol.

# Where do I get games?

- https://www.pokitto.com/games/

- https://archive.org/details/pokitto-games

# Installation 

- curl -sSL https://bit.ly/Pokitto-Installer | bash

# Qjoypad Mappings

Please map the following keys to your controller 

Key ------------- Function In Emu
---------------------------------------
Esc ------------- Quit PokittoEmu

F2 -------------- Save a screenshot as PNG

F3 -------------- Toggle screen recording

F5 -------------- Restart

F8 -------------- Pause/resume emulation

Arrow keys ------ D-pad directions

A --------------  A button

S/B ------------- B button

D/C ------------- C button

F --------------- Flash button


# ES Systems Entry 

- ATM you will need to add the following to es-systems.cfg



          <system>
    
          <name>pokitto</name>
    
          <fullname>Pokitto</fullname>
    
          <path>/home/pi/RetroPie/roms/pokitto</path>
    
          <extension>.BIN .bin .pop .POP</extension>
    
          <command>/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ pokitto %ROM%</command>
    
          <platform>pokitto</platform>
    
          <theme>pokitto</theme>
    
          </system> 

