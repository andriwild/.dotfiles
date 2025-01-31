---- Escape-Funktion für sed
local function escape(str)
    return str:gsub("([%*%[%]%(%)%.%+%-%?%^%$%%])", "\\%1")
end

-- Make sure the theme is added to the packages:
-- (use{"catppuccin/nvim", as ="catppuccin"})
local NVIM_LIGHT = "catppuccin"
local NVIM_DARK  = "rose-pine"

local ALACRITTY_LIGHT = "colors: *Light"
local ALACRITTY_DARK  = "# colors: *Light"

-- local ALACRITTY_LIGHT = "# bbb"
-- local ALACRITTY_DARK  = "# aaa"
local TMUX_LIGHT = "light"
local TMUX_DARK  = "dark"

local TMUX_CONFIG      = "~/.config/tmux/tmux.conf"
local ALACRITTY_CONFIG = "~/.config/alacritty/alacritty.yml"


function ColorMyPencils(color)
	color = color or NVIM_DARK
	vim.cmd.colorscheme(color)

    local background = "none"
    if color == NVIM_DARK then
        vim.cmd("set background=dark")
    else
        vim.cmd("set background=light")
        background = "#f8f8f2"
    end

	vim.api.nvim_set_hl(0, "Normal", { bg = background })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = background })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = background })
end

-- Since tmux does not have an option for live reload, 
-- manual loading of the configuration is required
 local function refreshTmuxConfig()
   local cmd = (string.format("tmux source-file %s", TMUX_CONFIG))
   os.execute(cmd)
 end

 local function replaceInConfigFile(searchFor, replaceWith, file)
   local cmd = string.format("sed -i 's/%s/%s/' %s", escape(searchFor), escape(replaceWith), file)
   os.execute(cmd)
 end

local function Light()
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
