-- Entry point: leader keys must be set before lazy.nvim loads any plugin.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.lazy")
require("config.keymaps")
