-- Make sure the theme is added to the packages:
-- (use{"catppuccin/nvim", as ="catppuccin"})
local NVIM_LIGHT = "catppuccin-latte"
local NVIM_DARK  = "catppuccin-mocha"

local ALACRITTY_LIGHT = NVIM_LIGHT
local ALACRITTY_DARK  = NVIM_DARK

local TMUX_LIGHT = "light"
local TMUX_DARK  = "dark"

local TMUX_CONFIG      = "~/.config/tmux/tmux.conf"
local ALACRITTY_CONFIG = "~/.config/alacritty/alacritty.yml"

function ColorMyPencils(color)
	color = color or NVIM_DARK
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

-- Since tmux does not have an option for live reload, 
-- manual loading of the configuration is required
local function refreshTmuxConfig()
  local cmd = (string.format("tmux source-file %s", TMUX_CONFIG))
  os.execute(cmd)
end

local function replaceInConfigFile(searchFor, replaceWith, file)
  local cmd = string.format("sed -i 's/%s/%s/' %s", searchFor, replaceWith, file)
  os.execute(cmd)
end

local function Light ()
  ColorMyPencils(NVIM_LIGHT)
  replaceInConfigFile(ALACRITTY_DARK, ALACRITTY_LIGHT, ALACRITTY_CONFIG)
  replaceInConfigFile(TMUX_DARK,      TMUX_LIGHT,      TMUX_CONFIG)
  refreshTmuxConfig()
end

local function Dark()
  ColorMyPencils(NVIM_DARK)
  replaceInConfigFile(ALACRITTY_LIGHT, ALACRITTY_DARK, ALACRITTY_CONFIG)
  replaceInConfigFile(TMUX_LIGHT,      TMUX_DARK,      TMUX_CONFIG)
  refreshTmuxConfig()
end

ToggleTheme = function ()
  if vim.g.colors_name == NVIM_DARK then
    Light()
  else
    Dark()
  end
end


Dark()
