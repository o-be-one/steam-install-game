#! /bin/bash

######
# Script to setup linux game server with SteamCMD
#
# Autor ? o_be_one de r0x.fr
# Howto ? Edit the script, execute and answer questions
######


### Vars to edit :

# What is your Steam account ?
chkhash=""
USER="your-steam-username"
PASS="your-steam-password"

# SteamCMD path :
DEFSTEAM=~/steamcmd

# Where to install games ?
DEFWHERE=~


### Edit ... at your own risks.

echo -e "\nThis script will install Steam game\n"

echo "Where is SteamCMD ? [$DEFSTEAM]"
read STEAM
[[ -z $STEAM ]] && STEAM=$DEFSTEAM

echo "What is the name of your game (will create folder with this name) ?"
read GAME

until [[ $ID =~ ^-?[0-9]+$ ]]
do
        echo "What is the game Steam AppID ?"
        read ID
done

echo "Where to setup $GAME (don't forget, the folder $GAME will be created in) ? [$DEFWHERE]"
read WHERE
[[ -z $WHERE ]] && WHERE=$DEFWHERE

echo "Add some setup arguments ?"
read SUPP

echo -e "\nOk, installation of $GAME (ID : $ID) in $WHERE/$GAME ..."
read -p "Press [ENTER] to start setup ..."

mkdir -p $WHERE/$GAME

cd $STEAM 
wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
chkhash=$(md5sum steamcmd_linux.tar.gz | cut -d' ' -f1)
if test "$chkhash" == "09e3f75c1ab5a501945c8c8b10c7f50e" 
then
  echo ----- Checksum OK -------
else
  echo ----- Checksum FAIL ------- $chkhash
  exit 0
fi

tar -xvzf steamcmd_linux.tar.gz
./steamcmd.sh +login $USER $PASS +force_install_dir $WHERE/$GAME +app_update $ID $SUPP +exit && cd $WHERE/$GAME
