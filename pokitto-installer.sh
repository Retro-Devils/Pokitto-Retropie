#!/bin/bash

export NCURSES_NO_UTF8_ACS=1
###----------------------------###
### INSTALLER MENU FUNCTIONS   ###
###----------------------------###
function pokitto-menu() {
    local choice

    while true; do
        choice=$(dialog --backtitle "$BACKTITLE" --title "POKITTO RETROPIE INSTALLER V1.02 " \
            --ok-label Select --cancel-label Exit-Installer \
            --menu "PIKITTO RETROPIE INSTALLER" 25 40 30 \
            1 "Install Pokitto  " \
            2 "Pokitto Emu Info   " \
            2>&1 > /dev/tty)

        case "$choice" in
            1) install-pokitto  ;;
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


function install-pokitto() {
echo "
CHECKING IF POKITTO EMU IS INSTALLED
-------------------------------------" 
sleep 2
if [ -d "/opt/retropie/emulators/pokitto" ]; then sudo rm -R /opt/retropie/emulators/pokitto; fi
if [ -d "/opt/retropie/configs/pokitto" ]; then sudo rm -R /opt/retropie/configs/pokitto; fi
if [ -f "/usr/local/bin/pokitto" ]; then sudo rm /usr/local/bin/pokitto; fi
if [ -f "$HOME/pokitto.zip" ]; then sudo rm $HOME/pokitto.zip; fi
echo "
CHECK COMPLETE
-------------------------------------" 
sleep 3
echo "
Installing/Checking For Dependencies
-------------------------------------" 
sleep 1
echo "Installing P7Zip"
sudo apt-get install -y p7zip
echo "Installing unzip"
sudo apt-get install -y unzip
echo "Installing LibSDl2-Net"
sudo apt-get install -y libsdl2-net-dev
echo "Installing Window Manager Stuff"
sudo apt-get install -y matchbox-window-manager
sudo apt install libsdl2-image-dev
sudo apt-get install qjoypad
if [ ! -f /usr/bin/startx ]; then
dialog  --sleep 1 --title "PIXEL DESKTOP NOT INSTALLED !! " --msgbox " 
INSTALLING NOW" 0 0
cd $HOME/RetroPie-Setup
sudo ./retropie_packages.sh raspbiantools lxde
echo "
-----------------------------
Dependencies Install Finished
-----------------------------"
sudo mkdir /opt/retropie/configs/pokitto
mkdir $HOME/RetroPie/roms/pokitto
sudo wget https://github.com/Retro-Devils/Pokitto-Retropie/raw/main/pokitto.zip -P $HOME/
sudo unzip $HOME/pokitto.zip
rm $HOME/pokitto.zip
cd $HOME/pokitto
sudo make
sleep 1
cd
sudo cp -R $HOME/pokitto /opt/retropie/emulators/
sudo chmod -R 777 /opt/retropie/emulators/pokitto/
sudo rm -R $HOME/pokitto
sudo wget https://raw.githubusercontent.com/Retro-Devils/Pokitto-Retropie/main/emulators.cfg -P /opt/retropie/configs/pokitto/
wget https://raw.githubusercontent.com/Retro-Devils/Pokitto-Retropie/main/pokitto.lyt -P $HOME/.qjoypad3/
wget https://raw.githubusercontent.com/Retro-Devils/Pokitto-Retropie/main/pokitto -P $HOME/
sudo cp $HOME/pokitto -f /usr/local/bin/pokitto
rm $HOME/pokitto
sudo chmod -R 777 /opt/retropie/configs/pokitto/
sudo chmod -R 777 /opt/retropie/emulators/pokitto/
sudo chmod 777 /usr/local/bin/pokitto
sleep 1
else
echo "
-----------------------------
Dependencies Install Finished
-----------------------------"
sudo mkdir /opt/retropie/configs/pokitto
mkdir $HOME/RetroPie/roms/pokitto
sudo wget https://github.com/Retro-Devils/Pokitto-Retropie/raw/main/pokitto.zip -P $HOME/
sudo unzip $HOME/pokitto.zip
rm $HOME/pokitto.zip
cd $HOME/pokitto
sudo make
sleep 1
cd
sudo cp -R $HOME/pokitto /opt/retropie/emulators/
sudo chmod -R 777 /opt/retropie/emulators/pokitto/
sudo rm -R $HOME/pokitto
sudo wget https://raw.githubusercontent.com/Retro-Devils/Pokitto-Retropie/main/emulators.cfg -P /opt/retropie/configs/pokitto/
wget https://raw.githubusercontent.com/Retro-Devils/Pokitto-Retropie/main/pokitto.lyt -P $HOME/.qjoypad3/
wget https://raw.githubusercontent.com/Retro-Devils/Pokitto-Retropie/main/pokitto -P $HOME/
sudo cp $HOME/pokitto -f /usr/local/bin/pokitto
rm $HOME/pokitto
sudo chmod -R 777 /opt/retropie/configs/pokitto/
sudo chmod -R 777 /opt/retropie/emulators/pokitto/
sudo chmod 777 /usr/local/bin/pokitto
sleep 1
fi
dialog  --sleep 1 --title "INSTALL COMPLETE" --msgbox "
- YOU WILL NEED TO MANUALLY EDIT ES-SYSTEMS.CFG
- A FOLDER HAS BEEN MADE FOR YOUR GAMES
THE FOLLOWING IS WHAT YOU NEED TO ADD TO ES-SYSTEMS.CFG
  <system>
    <name>pokitto</name>
    <fullname>Pokitto</fullname>
    <path>/home/pi/RetroPie/roms/pokitto</path>
    <extension>.BIN .bin </extension>
    <command>/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ pokitto %ROM%</command>
    <platform>pokitto</platform>
    <theme>pokitto</theme>
  </system>" 0 0
}


pokitto-menu
