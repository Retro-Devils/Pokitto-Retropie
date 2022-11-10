#!/bin/bash

export NCURSES_NO_UTF8_ACS=1
###----------------------------###
### INSTALLER MENU FUNCTIONS   ###
###----------------------------###
function pokitto-menu() {
    local choice

    while true; do
        choice=$(dialog --backtitle "$BACKTITLE" --title "PIKITTO RETROPIE INSTALLER V1.00 " \
            --ok-label Select --cancel-label Exit-Installer \
            --menu "PIKITTO RETROPIE INSTALLER" 25 50 30 \
            1 "Install Pokitto  " \
            2 "Pokitto Emu Info   " \
            2>&1 > /dev/tty)

        case "$choice" in
            1) install_pokitto  ;;
            2) info        ;;
            -) no ;;
            *) break       ;;
        esac
    done
}

function info() {
dialog  --sleep 1 --title "INSTALL COMPLETE" --msgbox "
----------------Pokitto   Emu----------------

An emulator for the Pokitto DIY handheld game system.

The development library can be found at the PokittoLib repository." 0 0
}

function install_pokitto() {
wget https://github.com/Retro-Devils/Pokitto-Retropie/raw/main/PokittoEmu-1.0.2.zip
unzip $HOME/PokittoEmu-1.0.2.zip
rm $HOME/PokittoEmu-1.0.2.zip
cd $HOME/PokittoEmu-1.0.2
make
sleep 1
cd
if [ ! -d "$HOME/.qjoypad3" ]; then sudo apt-get install qjoypad; fi
sudo apt-get install sdl1
sudo mkdir /opt/retropie/configs/pokitto
mkdir $HOME/RetroPie/roms/pokitto
sudo wget https://raw.githubusercontent.com/Retro-Devils/Pokitto-Retropie/main/emulators.cfg -P /opt/retropie/configs/pokitto/
wget https://raw.githubusercontent.com/Retro-Devils/Pokitto-Retropie/main/pokitto.lyt -P $HOME/.qjoypad3/
wget https://raw.githubusercontent.com/Retro-Devils/Pokitto-Retropie/main/pokitto -P $HOME/
sudo cp $HOME/pokitto -f /usr/local/bin/pokitto
rm $HOME/pokitto
sudo chmod -R 755 /opt/retropie/configs/pokitto/
sleep 1
dialog  --sleep 1 --title "INSTALL COMPLETE" --msgbox "
- YOU WILL NEED TO MANUALLY EDIT ES-SYSTEMS.CFG
- A FOLDER HAS BEEN MADE FOR YOUR GAMES
THE FOLLOWING IS WHAT YOU NEED TO ADD TO PES-SYSTEMS.CFG
  <system>
    <name>pokitto</name>
    <fullname>Pokitto</fullname>
    <path>/home/pi/RetroPie/roms/pokitto</path>
    <extension>.BIN .bin </extension>
    <command>pokitto %ROM%</command>
    <platform>pokitto</platform>
    <theme>pokitto</theme>
  </system>" 0 0
}

pokitto-menu
