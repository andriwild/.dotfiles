# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export PATH="$PATH:$HOME/.local/bin"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="arrow"
ZSH_THEME="awesomepanda"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    aliases
    zsh-syntax-highlighting 
    zsh-autosuggestions 
    git 
    docker 
    docker-compose
    )

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"
export EDITOR="/usr/bin/nvim"
export VISUAL="/usr/bin/nvim"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

bindkey -s ^f "tmux-sessionizer.sh\n"
# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#

# General
alias zshconfig="nvim ~/.zshrc && source /home/andri/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias cheat="tldr"
alias pac="pacman"
alias v="nvim"
alias vim="nvim"
alias vi="nvim"
alias hg="history | grep $1"
alias xclip="xclip -selection clipboard"
alias tree="tree -L 2"

# Git
alias gitcount="git rev-list --all --count"

alias bootRun="./gradlew bootRun"
alias run-mongo="mongod --dbpath ~/SwitchDrive/4-semester/webfr/Applications/mongodb/data/db"
alias HD="cd /run/media/andri/Ardita/"

alias cabaltest="cabal test --test-show-detail=direct"

#Zig
alias zrun="zig build run"
alias ztest="zig build test"

# Arduino
alias up="arduino-cli compile && arduino-cli upload"
alias serial="stty 9600 -F /dev/ttyUSB0 raw -echo && cat /dev/ttyUSB0"
alias acli="arduino-cli"

# Python
alias newenv="python -m venv .venv && source .venv/bin/acitvate"

# pandoc --listings -H setup.tex -V geometry:"left=1cm, top=1cm, right=1cm, bottom=2cm" --pdf-engine=xelatex -V mainfont="DejaVu Sans" -V monofont="DejaVu Sans Mono"  -V fontsize=6pt ZF.md -o test.pdf

# Docker
alias dc="docker compose"

# Joplin
# alias todo="joplin use $1 && joplin mktodo $2"
function todo() {
  joplin use "$1"
  joplin mktodo "$2"
}

#IMVS
#BruggEye
alias bruggeye-server="ssh -i /home/andri/.ssh/bruggEye_switch_engines.pem  ubuntu@86.119.41.12"
alias bruggeye-yaler="java YalerTunnel client 127.0.0.1:10022 try.yaler.io:80 fhnw-imvs-e4-5f-01-57-1c-1d-ssh"
alias bruggeye-yaler-backup="java YalerTunnel client 127.0.0.1:10022 try.yaler.io:80 dc-a6-32-03-31-80-ssh"
alias bruggeye-remove-ssh-keys="ssh-keygen -R '[localhost]:10022'"
alias bruggeye-gateway="echo 'Yaler Tunnel acitv?' && ssh -i /home/andri/.ssh/bruggeye-edgegw.pem pi@localhost -p 10022 -o ServerAliveInterval=5"
alias bruggeye-gateway-backup="echo 'Yaler Tunnel acitv?' && ssh -i /home/andri/.ssh/bruggeye-edgegw-02.pem pi@localhost -p 10022 -o ServerAliveInterval=5"

# SoftEng
export PICO_TOOLCHAIN_PATH=/home/andri/workspace/raspi/xpack-arm-none-eabi-gcc-12.3.1-1.2/bin/
export PICO_SDK_PATH=/home/andri/workspace/raspi/pico/pico-sdk/
export PATH=/home/andri/workspace/raspi/xpack-arm-none-eabi-gcc-12.3.1-1.2/bin/:$PATH

alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"


# autoload -U +X bashcompinit && bashcompinit
# complete -o nospace -C /usr/bin/terraform terraform

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#[ -f "/home/andri/.ghcup/env" ] && source "/home/andri/.ghcup/env" # ghcup-env
# source /usr/share/nvm/init-nvm.sh
