#!/bin/bash

export NCURSES_NO_UTF8_ACS=1
###----------------------------###
### INSTALLER MENU FUNCTIONS   ###
###----------------------------###
function pikitto-menu() {
    local choice

    while true; do
        choice=$(dialog --backtitle "$BACKTITLE" --title "PIKITTO RETROPIE INSTALLER V1.00 " \
            --ok-label Select --cancel-label Exit-Installer \
            --menu "PIKITTO RETROPIE INSTALLER" 25 50 30 \
            1 "Install Pikitto  " \
            2 "Pikitto Emu Info   " \
            2>&1 > /dev/tty)

        case "$choice" in
            1) install_pikitto  ;;
            2) info        ;;
            -) no ;;
            *) break       ;;
        esac
    done
}

function info() {
dialog  --sleep 1 --title "INSTALL COMPLETE" --msgbox "
----------------PokittoEmu----------------

An emulator for the Pokitto DIY handheld game system.

The development library can be found at the PokittoLib repository." 0 0
}

function install_pikitto() {
wget https://github.com/Retro-Devils/Pokitto-Retropie/raw/main/PokittoEmu-1.0.2.zip
unzip $HOME/PokittoEmu-1.0.2.zip
rm $HOME/PokittoEmu-1.0.2.zip
cd $HOME/PokittoEmu-1.0.2
make
sleep 1
cd
if [ ! -d "$HOME/qjoypad3" ]; then sudo apt-get install qjoypad; fi
sudo apt-get install sdl1
sudo mkdir /opt/retropie/configs/pokitto
mkdir $HOME/RetroPie/roms/pokitto
sudo wget https://raw.githubusercontent.com/Retro-Devils/Pokitto-Retropie/main/emulators.cfg -P /opt/retropie/configs/pokitto/
wget https://raw.githubusercontent.com/Retro-Devils/Pokitto-Retropie/main/pokitto -P $HOME
sudo cp $HOME/pokitto -f /usr/local/bin/pokitto
rm $HOME/pokitto
sudo chmod -R 755 /opt/retropie/configs/pokitto/
sleep 1
CONTENT1="\t<system>\n\t\t<name>pokitto</name>\n\t\t<fullname>Pokitto</fullname>\n\t\t<path>/home/pi/RetroPie/roms/pokitto</path>\n\t\t<extension>.bin .BIN</extension>\n\t\t<command>pokitto %ROM%</command>\n\t\t<platform>pokitto</platform>\n\t\t<theme>pokitto</theme>\n\t\t</system>"
C1=$(echo $CONTENT1 | sed 's/\//\\\//g')
if grep -q "pokitto" "$HOME/.emulationstation/es_systems.cfg"; then echo "es_systems.cfg entry confirmed"
else
	sed "/<\/system>/ s/.*/${C1}\n&/" $HOME/.emulationstation/es_systems.cfg > $HOME/temp
	cat $HOME/temp > $HOME/.emulationstation/es_systems.cfg
	rm -f $HOME/temp
fi
dialog  --sleep 1 --title "INSTALL COMPLETE" --msgbox "
-YOUR ES SYSTEMS HAS BEEN EDITED
-A FOLDER HAS BEEN MADE FOR YOUR GAMES" 0 0
}

pikitto-menu