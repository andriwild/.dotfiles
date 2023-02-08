#!/bin/sh

echo "Hello from install script"

pacman -S bluez bluez-utils blueberry \
		zip unzip git curl tree wget upower yay \
		npm gcc sshfs perl-rename \
		neovim rofi \
		alsa-utils pavucontrol flameshot i3lock brightnessctl \
		arc-icon-theme xserver-xephyr \
		chromium qutebrowser \
		
yay -S awmtt

git clone --depth 1 https://github.com/wbthomason/packer.nvim\\n ~/.local/share/nvim/site/pack/packer/start/packer.nvim	
git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone --depth 1 https://github.com/streetturtle/awesome-wm-widgets.git ~/.config/awesome/

curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install java 17.0.5-librca

git clone --depth 1 https://github.com/P3rf/rofi-network-manager.git ~/.config/
git clone --depth 1 https://github.com/ClydeDroid/rofi-bluetooth.git ~/.config/
