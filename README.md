# Dotfiles Repo

## Setup a bare repository
```bash
# create a repo
git init --bare $HOME/.dotfiles
# or 
git clone --bare git@git...

# add this alias to your .zshrc or what you use instead
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

dotfiles config --local status.showUntrackedFiles no
```

## Migrate the data to a new maschine
```bash
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

# prevent from trouble
echo ".dotfiles" >> .gitignore

# clone the repo
git clone --bare git@github.com:AndriWild/.dotfiles.git $HOME/.dotfiles

# backup your current files, which will be overwritten from the repo or use the Atlassian script

dotfiles checkout
```

## Basic usage example:
```bash
dotfiles add /path/to/file
dotfiles commit -m "A short message"
dotfiles push
```

Consider the link to get more infos:
[Atalassian Tutorial](https://www.atlassian.com/git/tutorials/dotfiles)
