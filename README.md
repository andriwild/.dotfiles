# Dotfiles

My macOS dotfiles, managed with [GNU Stow](https://www.gnu.org/software/stow/).

The Linux setup (sway, waybar, alacritty, bare-repo workflow) that used to live
here is kept under the tag [`linux`](https://github.com/andriwild/.dotfiles/tree/linux).

## Layout

Every top-level directory is a Stow package. Its contents mirror `$HOME`, so
`stow <package>` creates symlinks from `~` into this repo.

| Package     | Files                                                   |
| ----------- | ------------------------------------------------------- |
| `aerospace` | `~/.aerospace.toml` (tiling window manager)             |
| `ghostty`   | `~/.config/ghostty/config`                              |
| `git`       | `~/.gitconfig`, `~/.config/git/ignore`                  |
| `idea`      | `~/.ideavimrc`                                          |
| `karabiner` | `~/.config/karabiner/` (whole directory, see below)     |
| `mise`      | `~/.config/mise/config.toml`                            |
| `nvim`      | `~/.config/nvim/`                                       |
| `raycast`   | `~/.config/raycast/scripts/` (Raycast script commands)  |
| `scripts`   | `~/.local/bin/`, `~/.local/share/aerokeys/`             |
| `starship`  | `~/.config/starship.toml`                               |
| `tmux`      | `~/.config/tmux/`                                       |
| `vscode`    | `~/Library/Application Support/Code/User/settings.json` |
| `zsh`       | `~/.zshrc`, `~/.zprofile`, `~/.bash_profile`            |

`Brewfile` lists all Homebrew formulae, casks and VS Code extensions.

### Scripts

- `aerospace-mode [on|off|toggle|status]` switches between the AeroSpace setup
  and plain macOS (window manager, trackpad gestures, Dock). AeroSpace runs
  `aerospace-mode on` at startup.
- `aerokeys` prints the AeroSpace keybindings from `~/.aerospace.toml`. The
  Raycast script command `AeroSpace Keys` wraps it.
- `tmux-sessionizer.sh` fuzzy-picks a project and opens or switches to its tmux
  session (`Ctrl+F` in zsh).

## Setup on a new Mac

```bash
# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Repo and packages
git clone git@github.com:andriwild/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
brew bundle --file=Brewfile

# Symlink everything (or name single packages, e.g. `stow zsh nvim`)
stow -t ~ */

# tmux plugin manager, then press prefix + I inside tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

If a target file already exists, Stow refuses to overwrite it. Either move it
away first, or run `stow --adopt -t ~ <package>`, which moves the existing file
into the repo. Check `git diff` afterwards and `git restore` what you don't want
to keep.

Karabiner-Elements only picks up changes when `~/.config/karabiner` itself is
the symlink, not `karabiner.json`. So make sure that directory does not exist
before stowing `karabiner`.

## Usage

Edits to the symlinked files land in the repo directly, so just commit them.

```bash
# Add a new file to a package
mkdir -p ~/.dotfiles/foo/.config/foo
mv ~/.config/foo/config ~/.dotfiles/foo/.config/foo/config
cd ~/.dotfiles && stow -t ~ foo

# Remove a package's symlinks
stow -D -t ~ foo

# Recreate the symlinks, e.g. after adding files to a package
stow -R -t ~ foo

# Update the Brewfile after installing or removing something
brew bundle dump --force --file=~/.dotfiles/Brewfile
```
