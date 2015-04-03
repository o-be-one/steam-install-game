#! /bin/bash

######
# Script to setup linux game server with SteamCMD
#
# Autor ? o_be_one de r0x.fr
# Howto ? Edit the script, execute and answer questions
######


### Variables a editer :

# What is your Steam account ?
USER="your-steam-username"
PASS="your-steam-password"

# Emplacement de Steam :
DEFSTEAM=~/steamcmd

# Ou installer le jeu ?
DEFWHERE=~


### Editer ce qui suit a vos risques ...

echo -e "\nCe script va installer un jeu/serveur Steam.\n"

echo "Ou est installer SteamCMD ? [$DEFSTEAM]"
read STEAM
[[ -z $STEAM ]] && STEAM=$DEFSTEAM

echo "Quel est le nom du jeu (creera le dossier du meme nom) ?"
read GAME

until [[ $ID =~ ^-?[0-9]+$ ]]
do
        echo "Quel est l'ID Steam du jeu a installer ?"
        read ID
done

echo "Dans quel dossier installer $GAME (n'oubliez pas, le dossier $GAME sera cree dedans) ? [$DEFWHERE]"
read WHERE
[[ -z $WHERE ]] && WHERE=$DEFWHERE

echo "Un argument a ajouter au setup ?"
read SUPP

echo -e "\nOk, installation de $GAME (ID : $ID) dans $WHERE/$GAME ..."
read -p "Appuyez sur [ENTREE] pour demarrer l'installation ..."

mkdir -p $WHERE/$GAME
cd $STEAM && ./steamcmd.sh +login $USER $PASS +force_install_dir $WHERE/$GAME +app_update $ID $SUPP +exit && cd $WHERE/$GAME
