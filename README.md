# Dotfiles Repo

## Setup a bare repository
1. git init --bare $HOME/.dotfiles
		or git clone --bare git@git...
2. alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
3. dotfiles config --local status.showUntrackedFiles no

## Basic usage example:
```bash
dotfiles add /path/to/file
dotfiles commit -m "A short message"
dotfiles push
```

Consider the link to get more infos:
[Atalassian Tutorial](https://www.atlassian.com/git/tutorials/dotfiles)
