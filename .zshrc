# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:/opt/zig/"
export PATH="$PATH:$HOME/.local/share/JetBrains/Toolbox/scripts/"
export PATH="$PATH:/opt/minio-binaries/"
export PATH="$PATH:/home/andri/.local/bin/bin"
export PATH="$PATH:/opt/arduino-ide_2.3.3_Linux_64bit"
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
export PATH="$PATH:/opt/jetbrains-toolbox"
export PATH="$PATH:/opt/typst-x86_64-unknown-linux-musl/"
export PATH="$PATH:/opt/zen/zen.linux-x86_64/zen/zen-bin"
export PATH="$PATH:/usr/local/go/bin"

export XDG_CURRENT_DESKTOP=sway
[ -f "/home/andri/.ghcup/env" ] && source "/home/andri/.ghcup/env" # ghcup-env

# expand history size
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="arrow"
ZSH_THEME="awesomepanda"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="false"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

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
    dirhistory
    aliases
    # zsh-autosuggestions 
    git 
    docker 
    docker-compose
    #zsh-vi-mode
    zsh-syntax-highlighting 
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

# zsh-vi-mode try to run tmux-sessionizer (dont't work)
# function run_t() {
#   tmux-sessionizer.sh
# }
# function zvm_after_lazy_keybindings() {
#   zvm_define_widget run_t
#   zvm_bindkey vicmd '^f' run_t
# }

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
alias svi="source .venv/bin/activate && nvim"
alias hg="history | grep $1"
alias xclip="xclip -selection clipboard"
alias tree="tree -L 3"

# Git
alias gitcount="git rev-list --all --count"

alias bootRun="./gradlew bootRun"
alias run-mongo="mongod --dbpath ~/SwitchDrive/4-semester/webfr/Applications/mongodb/data/db"
alias HD="cd /run/media/andri/Ardita/"

alias cabaltest="cabal test --test-show-detail=direct"

# Fugitive
alias G="nvim . -c G -c only"

#Zig
alias zrun="zig build run"
alias ztest="zig build test"

# Arduino
alias up="arduino-cli compile && arduino-cli upload"
alias serial="stty 9600 -F /dev/ttyACM0 raw -echo && cat /dev/ttyACM0"
alias acli="arduino-cli"

# Python
alias python="python3"
alias py="python3"
alias sou="source ./.venv/bin/activate"
alias newenv="python3 -m venv .venv && source .venv/bin/activate"
alias homieyaler="cd /home/andri/YalerTunnel/ && java YalerTunnel client 127.0.0.1:10022 try.yaler.io:80 fhnw-imvs-2c-cf-67-30-50-4f-ssh &"
alias homie4yaler="cd /home/andri/YalerTunnel/ && java YalerTunnel client 127.0.0.1:10022 try.yaler.io:80 fhnw-imvs-dc-a6-32-18-6f-4d-ssh &"


alias settings="gnome-control-center"
# pandoc --listings -H setup.tex -V geometry:"left=1cm, top=1cm, right=1cm, bottom=2cm" --pdf-engine=xelatex -V mainfont="DejaVu Sans" -V monofont="DejaVu Sans Mono"  -V fontsize=6pt ZF.md -o test.pdf
#
# Colored Terminals
#alias yellow-term="alacritty msg create-window -o 'colors.primary.background=#0000ff'"

alias yellow-term='alacritty msg create-window -o '\''colors.primary.background="#ffff00"'\'''

# Docker
alias dc="docker compose"

# Formatted date
alias fdate="date +'%R - %d.%b %Y'"

# Launch matlab and fix no window bug
alias matlab="env _JAVA_AWT_WM_NONREPARENTING=1 matlab" 

# fkill - kill process
fkill() {
    local pid 
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi  

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi  
}

# fh - repeat history
# fh – fuzzy-history with exact matching (-e/--exact)
fh() {
  local cmd
  cmd=$(
    ([ -n "$ZSH_NAME" ] && fc -l 1 || history)            |  # shell history
    sed -E 's/^[[:space:]]*[0-9]+\*?[[:space:]]*//'       |  # strip numbers / “*”
    tac                                                   |  # newest → oldest
    awk '!seen[$0]++'                                     |  # drop duplicates
    fzf --exact +s                                          # ⬅ exact (contiguous) match only
  ) || return

  print -z -- "${cmd//\\/\\\\}"                            # load into prompt
}


# ROS autocomplete enable for zsh
eval "$(register-python-argcomplete3 ros2)"
eval "$(register-python-argcomplete3 colcon)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_OPTS='--height=80% --layout=reverse --info=inline --border --margin=1 --padding=1'

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/minio-binaries/mc mc
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
