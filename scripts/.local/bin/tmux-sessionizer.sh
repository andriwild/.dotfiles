#!/bin/zsh

# inspired by theprimeagen (via poeik/dotfiles + andriwild/.dotfiles)
if [[ $# -eq 1 ]]; then
    selected=$1
else

directories=(
  $(find ~/fhnw/MSE -mindepth 1 -maxdepth 2 -type d 2>/dev/null)
  $(find ~/repos/ -mindepth 1 -maxdepth 1 -type d 2>/dev/null)
  $(find ~/repos/spesen-app -mindepth 1 -maxdepth 1 -type d -not -name '.*' 2>/dev/null)
  $(find ~/workspace/ -mindepth 1 -maxdepth 2 -type d 2>/dev/null)
  $(find ~/.config/ -mindepth 1 -maxdepth 1 2>/dev/null)
  ~
)
selected=$(echo $directories | tr " " "\n" | fzf)

fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _) # select the last path element

# create new session if a session with this name does not exist
if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name -c $selected
fi

if [[ -z $TMUX ]]; then
  tmux attach -t $selected_name
else
  tmux switch-client -t $selected_name
fi
