#!/usr/bin/bash
#set -e
echo "###################################"
echo "# Adding/Enabling Wayland Support #"
echo "###################################"
sleep 3

sudo pacman -S --noconfirm --needed xorg-xwayland kwayland-integration plasma-wayland-session plasma-wayland-protocols qt6-wayland

sleep 3
echo "#################################"
echo "#      Done! Please Reboot      #"
echo "#################################"
sleep 6
