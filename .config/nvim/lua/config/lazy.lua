local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "
vim.opt.termguicolors = true

local lazy = require("lazy")
lazy.setup("plugins")
vim.keymap.set("n", "<leader>L", lazy.show)

require("config.color")
ColorMyPencils("rose-pine")
