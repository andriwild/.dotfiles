#!/bin/sh

echo "Install script... "

sudo pacman -Syyu

sudo pacman -S --noconfirm yay
sudo yay -Sua

sudo pacman -S --noconfirm bluez bluez-utils blueberry cifs-utils \
		zip unzip git curl tree wget htop tldr sshfs gcc g++ \
		make cmake gmp ncurses realpath xz-utils \
		npm fzf \
		neovim rofi nemo alacritty code tmux \
		xorg-server-xephyr alsa-utils pavucontrol upower brightnessctl i3lock xclip \
		arc-icon-theme arandr \
		hamster-time-tracker \
		chromium qutebrowser firefox notion \
		thunderbird owncloud-client flameshot onlyoffice-desktopeditors okular texlive-most \
		
sudo yay -S awmtt

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
