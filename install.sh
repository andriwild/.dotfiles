#!/bin/sh

echo "Install script... "

if [ "$(id -u)" != "0" ]; then
   echo "Dieses Skript muss als Root ausgeführt werden." 1>&2
   exit 1
fi

read -p "Ist yay bereits installiert? [y/n] " answer

if [ "$answer" == "${answer#[Nn]}" ] ;then
    pacman install --noconfirm yay
fi

pacman -S --noconfirm bluez bluez-utils blueberry \
		zip unzip git curl tree wget upower xorg-server-xephyr \
		npm gcc sshfs  \
		neovim rofi nemo alacritty\
		alsa-utils pavucontrol flameshot i3lock brightnessctl \
		arc-icon-theme \
		chromium qutebrowser \
		
yay -S awmtt
# xserver-xephyr 

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim	
git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone --depth 1 https://github.com/streetturtle/awesome-wm-widgets.git
mv awesome-wm-widgets ~/.config/awesome

curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install java 17.0.5-librca

git clone --depth 1 https://github.com/P3rf/rofi-network-manager.git
mv rofi-network-manager ~/.config/
git clone --depth 1 https://github.com/ClydeDroid/rofi-bluetooth.git ~/.config/
mv rofi-bluetooth ~/.config/
