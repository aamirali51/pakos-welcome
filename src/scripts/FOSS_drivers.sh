#!/bin/bash
#set -e
##################################################################################################################
# Written to be used on 64 bits computers
# Author 	: 	DarkXero
# Website 	: 	http://xerolinux.xyz
##################################################################################################################
echo
tput setaf 3
echo "###############################################################################"
echo "#                XeroLinux Free (Open Source) Driver Installer                #"
echo "#                                                                             #"
echo "#                            !!!! ATTENTION !!!                               #"
echo "#                                                                             #"
echo "#           This Will Install GPU Drivers For Any Intel or AMD GPUs           #"
echo "#                                                                             #"
echo "#                  Carefully Select The Appropriate Drivers.                  #"
echo "###############################################################################"
tput sgr0
echo
echo "Select which Drivers to Install."
echo
echo "################# GPU Checker #################"
echo
echo "1.  Check Which GPU You Have."
echo
echo "############# Open Source Drivers #############"
echo
echo "2.  AMD GPU Free."
echo "3.  Intel GPU Free."
echo "4.  ATI (Radeon HD) GPU Free."
echo
echo "Type Your Selection. To Exit, just close Window."
echo

while :; do

read CHOICE

case $CHOICE in

    1 )
      echo
      echo "##########################################"
      echo "          Checking Installed GPU          "
      echo "##########################################"
      echo
			sleep 3
			lspci -x | grep VGA
			sleep 3
      echo
            glxinfo | grep -E "OpenGL vendor|OpenGL renderer*"
            sleep 3
      echo
      echo "#######################################"
      echo "                 Done !                "
      echo "#######################################"
            exit
      ;;

    2 )
      echo
      echo "##########################################"
      echo "     Installing AMD GPU Free Drivers      "
      echo "##########################################"
			sleep 3
			sudo pacman -S --noconfirm xf86-video-amdgpu libvdpau-va-gl vulkan-swrast libva-vdpau-driver
			sleep 3
      echo "#######################################"
      echo "                 Done !                "
      echo "#######################################"
            exit
      ;;

    3 )
      echo
      echo "##########################################"
      echo "    Installing Intel GPU Free Drivers     "
      echo "##########################################"
			sleep 3
			sudo pacman -S --noconfirm xf86-video-intel vulkan-intel lib32-vulkan-intel vulkan-swrast
			sleep 3
      echo "#######################################"
      echo "                 Done !                "
      echo "#######################################"
            exit
      ;;

    4 )
      echo
      echo "##########################################"
      echo "     Installing ATI GPU Free Drivers      "
      echo "##########################################"
			sleep 3
			sudo pacman -S --noconfirm xf86-video-ati vulkan-radeon lib32-vulkan-radeon libvdpau-va-gl vulkan-swrast libva-vdpau-driver
			sleep 3
      echo "#######################################"
      echo "                 Done !                "
      echo "#######################################"
            exit

      ;;

    * )
      echo "#################################"
      echo "    Choose the correct number    "
      echo "#################################"
      ;;
esac
done
