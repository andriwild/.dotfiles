# --- History ---
HISTSIZE=10000                 # Number of commands kept in memory
SAVEHIST=10000                 # Number of commands saved to the history file
setopt SHARE_HISTORY           # Share history across all open terminal sessions instantly
setopt HIST_IGNORE_DUPS        # Don't record a command if it's identical to the previous one

# Show file preview (with syntax highlighting) when using Ctrl+T
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :200 {}'"

# Ctrl+T / Alt+C: search with fd and skip caches, app data and installed files
# nobody edits by hand. Hidden files stay in (dotfiles are the point).
_fzf_excludes=(
  .git Library Applications node_modules
  .cache .Trash .venv __pycache__ .DS_Store
  .npm .cargo .rustup .orbstack .docker
  .local/share .local/state .zsh_sessions .zcompcache
  .claude/plugins .claude/skills .claude/backups .claude/projects
  .claude/shell-snapshots .claude/paste-cache .claude/statsig
  .claude/todos .claude/sessions .claude/cache .claude/file-history
  .gradle .pub-cache .dartServer .dart_tool .vscode .nvm .sdkman .bundle
  .cocoapods .expo .swiftpm .android OrbStack .tmux/plugins
  '*.app' '*.photoslibrary'
)
# (q) quotes each arg, so globs like *.app reach fd instead of being expanded by eval.
_fzf_fd_args="--hidden --follow ${(@q)${_fzf_excludes[@]/#/--exclude=}}"
export FZF_CTRL_T_COMMAND="fd --type f $_fzf_fd_args"
export FZF_ALT_C_COMMAND="fd --type d $_fzf_fd_args"
export FZF_DEFAULT_COMMAND="$FZF_CTRL_T_COMMAND"

# --- Completion ---
autoload -Uz compinit && compinit   # Enable zsh's built-in tab completion system

# --- Plugins ---
# Suggest commands from history as you type (accept with →)
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# Highlight valid commands green and invalid ones red while typing
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# --- Tools ---
eval "$(starship init zsh)"    # Fast, informative prompt (git branch, language versions, etc.)
eval "$(zoxide init zsh)"      # Smarter cd: jump to frequent directories with `z <name>`
source <(fzf --zsh)            # Fuzzy finder: Ctrl+R for history search, Ctrl+T for files

# Regenerate AeroSpace cheat sheet (without workspace bindings) for Alfred / Quick Look
alias aerosheet="sed -n '/^\[mode.main.binding\]/,/^\[/p' ~/.aerospace.toml | grep -E '^\s*[a-z].* = ' | grep -v workspace | sed -E 's/^\s+//' | column -t -s '=' > ~/Documents/AeroSpace-Shortcuts.txt"

# --- Aliases: general ---
alias ll='ls -lhG'             # Long list, human-readable sizes, colored
alias l='ls -lhG'              # Long list, human-readable sizes, colored
alias la='ls -lahG'            # Like ll, but include hidden files
alias ..='cd ..'               # Go up one directory
alias ...='cd ../..'           # Go up two directories
alias reload='source ~/.zshrc' # Reload shell config after editing
alias zshrc='code ~/.zshrc'    # Open this config in VS Code
alias vi='nvim'
alias vim='nvim'
alias py='python3'

# --- Aliases: git ---
alias g='git'
alias gs='git status -sb'                  # Short status with branch info
alias ga='git add'
alias gaa='git add --all'                  # Stage all changes
alias gc='git commit -m'                   # Commit with message: gc "msg"
alias gca='git commit --amend --no-edit'   # Add staged changes to last commit
alias gp='git push'
alias gpl='git pull --rebase'              # Pull and rebase local commits on top
alias gco='git checkout'
alias gsw='git switch'                     # Switch branches (modern checkout)
alias gb='git branch'
alias gd='git diff'
alias gds='git diff --staged'              # Diff of staged changes
alias gl='git log --oneline --graph --decorate -20'  # Compact graph of last 20 commits
alias gst='git status'
alias gcmsg='git commit -m'

# --- Aliases: docker ---
alias d='docker'
alias dc='docker compose'
alias dps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'  # Readable running containers
alias dpsa='docker ps -a'                  # All containers, including stopped
alias di='docker images'
alias dex='docker exec -it'                # Shell into container: dex <name> sh
alias dlog='docker logs -f'                # Follow container logs
alias dcu='docker compose up -d'           # Start stack in background
alias dcd='docker compose down'            # Stop and remove stack
alias dcl='docker compose logs -f'         # Follow logs of the whole stack
alias dprune='docker system prune -f'      # Remove unused containers, networks, images



# Own scripts
export PATH="$HOME/.local/bin:$PATH"
bindkey -s ^f "tmux-sessionizer.sh\n"   # Ctrl+F: fuzzy-pick a project and open/switch tmux session

# --- Node (nvm) ---
export NVM_DIR="$HOME/.nvm"
source /opt/homebrew/opt/nvm/nvm.sh                        # Load nvm itself
source /opt/homebrew/opt/nvm/etc/bash_completion.d/nvm     # Tab completion for nvm

# Switch Node version automatically when entering a directory with .nvmrc
# (and fall back to the default version when leaving it again)
# nvm itself is slow (~1s), so find .nvmrc in pure zsh and only call nvm
# when the governing .nvmrc actually changes.
_nvm_last_nvmrc="unset"
_nvm_auto_use() {
  local dir=$PWD nvmrc=""
  while true; do
    [[ -f "$dir/.nvmrc" ]] && { nvmrc="$dir/.nvmrc"; break; }
    [[ "$dir" == "/" || -z "$dir" ]] && break
    dir=${dir:h}
  done
  [[ "$nvmrc" == "$_nvm_last_nvmrc" ]] && return
  _nvm_last_nvmrc=$nvmrc
  if [[ -n "$nvmrc" ]]; then
    local want current
    want="$(nvm version "$(cat "$nvmrc")")"
    current="$(nvm current)"
    if [[ "$want" == "N/A" ]]; then
      nvm install            # .nvmrc asks for a version that isn't installed yet
    elif [[ "$want" != "$current" ]]; then
      nvm use --silent
    fi
  elif [[ "$(nvm current)" != "$(nvm version default)" ]]; then
    nvm use default --silent
  fi
}
autoload -U add-zsh-hook
add-zsh-hook chpwd _nvm_auto_use
_nvm_auto_use

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# mise (ruby etc.)
eval "$(mise activate zsh)"
