# Neovim config

Lean Neovim setup for macOS. Leader key is `<Space>`.

## Layout

```
init.lua                 leader keys, then config modules
lua/config/options.lua   editor options, diagnostics, providers
lua/config/lazy.lua      lazy.nvim bootstrap
lua/config/keymaps.lua   global keymaps
lua/plugins/*.lua        one plugin per file
```

## Requirements

Installed via Homebrew: `neovim` (>= 0.11), `ripgrep`, `fd`, `stylua`,
`lua-language-server`, `tree-sitter-cli`, `font-jetbrains-mono-nerd-font`.

Set your terminal font to **JetBrainsMono Nerd Font Mono** so icons render.
In Ghostty: `font-family = "JetBrainsMono Nerd Font Mono"` in `~/.config/ghostty/config`.

## Adding an LSP server

Add an entry to the `servers` table in `lua/plugins/lsp.lua` (keys are
nvim-lspconfig server names), then install the binary with `:Mason`.

## Keymaps

Mirrors the Linux dotfiles, except harpoon (see below).

### General

| Key | Mode | Action |
| --- | --- | --- |
| `<leader>pv` | n | Open netrw |
| `<Esc>` | n | Clear search highlight |
| `<Esc><Esc>` | t | Exit terminal mode |
| `J` | n | Join lines, keep cursor |
| `J` / `K` | v | Move selection down/up |
| `<C-d>` / `<C-u>` | n | Half page down/up, centered |
| `n` / `N` | n | Next/previous search match, centered |
| `<leader>y` | n, v | Yank to system clipboard |
| `<leader>Y` | n | Yank line to system clipboard |
| `<leader>p` | x | Paste over selection without yanking it |
| `<leader>s` | n | Substitute word under cursor |
| `<leader>'` | n | Toggle light/dark |
| `<leader>j` / `<leader>k` | n | Previous / next location list item |
| `[q` / `]q` | n | Previous / next quickfix item |
| `<leader>bn` / `<leader>bp` / `<leader>bd` | n | Next / previous / delete buffer |
| `<C-h>` `<C-j>` `<C-k>` `<C-l>` | n | Move between windows and tmux panes |

### Search (telescope)

| Key | Mode | Action |
| --- | --- | --- |
| `<leader>sf` | n | Find file |
| `<leader>sg` | n | Live grep string |
| `<leader>sw` | n | Search word under cursor |
| `<leader>sh` | n | Search help tags |
| `<leader>sd` | n | Search diagnostics |
| `<leader>ss` | n | Find LSP symbol |
| `<leader>ws` | n | Find LSP workspace symbol |
| `<leader>g` | n | Find git file |
| `<leader>km` | n | Search keymaps |
| `<leader>v` | n | Treesitter symbols |
| `<leader>zz` | n | Spell suggest |
| `<leader>x` | n | Fuzzily search in current buffer |
| `<C-j>` / `<C-k>` | i | Next / previous result (inside a picker) |

### LSP

| Key | Mode | Action |
| --- | --- | --- |
| `gd` | n | Go to definition |
| `gi` | n | Go to implementation |
| `gr` | n | Go to references |
| `K` | n | Hover documentation |
| `<leader>gd` | n | Go to definition in a vertical split |
| `<leader>r` | n | Rename symbol |
| `<leader><CR>` | n, v | Code action |
| `<leader>vd` | n | Show line diagnostics |
| `<leader>vws` | n | Workspace symbol |
| `<leader>vrr` | n | List references |
| `<leader>2` / `<leader>3` | n | Next / previous diagnostic |
| `<leader>cf` | n, v | Format buffer (also runs on save) |

### Completion (nvim-cmp)

| Key | Mode | Action |
| --- | --- | --- |
| `<C-Space>` | i | Open completion menu |
| `<Tab>` / `<S-Tab>` | i, s | Next / previous item, or jump snippet placeholder |
| `<CR>` | i | Confirm selected item |
| `<C-b>` / `<C-f>` | i | Scroll documentation |
| `<C-e>` | i | Abort completion |

### Files, marks, git

| Key | Mode | Action |
| --- | --- | --- |
| `<leader>t` | n | Toggle file explorer |
| `<leader>T` | n | Reveal current file in explorer |
| `<leader>u` | n | Toggle undotree |
| `<leader>gs` | n | Git status |
| `<leader>gb` | n | Git blame |
| `<leader>gl` | n | Git log |
| `<leader>ha` | n | Harpoon: add file |
| `<leader>hh` | n | Harpoon: quick menu |
| `<leader>h1` … `<leader>h4` | n | Harpoon: jump to file 1-4 |

Harpoon sits on `<leader>h` instead of the Linux `<C-e>`/`<C-t>`/`<C-n>`/`<C-s>`,
which would shadow Vim defaults.

### Claude Code

| Key | Mode | Action |
| --- | --- | --- |
| `<leader>ac` | n | Toggle Claude Code |
| `<leader>af` | n | Focus Claude Code |
| `<leader>ab` | n | Add current buffer to context |
| `<leader>as` | v | Send selection to Claude Code |
| `<leader>as` | n | Add file under cursor (in the file explorer) |
| `<leader>aa` | n | Accept diff |
| `<leader>ad` | n | Deny diff |

## Theme

VS Code Dark+ / Light+ (`Mofiqul/vscode.nvim`), paired with Ghostty so both
share one background.

`Normal` and `NormalNC` are set to `bg = NONE`, so Neovim paints no background
of its own and the terminal shows through. Floats and popups keep their own
background so they stay readable.

| | dark | light |
| --- | --- | --- |
| Ghostty (`theme`) | `Dark+` (`#1e1e1e`) | `Builtin Light` (`#ffffff`) |
| Neovim | `vscode` (dark) | `vscode` (light) |

Neovim switches via auto-dark-mode.nvim, Ghostty via its own
`theme = light:...,dark:...` setting.
