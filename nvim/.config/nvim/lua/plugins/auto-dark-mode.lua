return {
  "f-person/auto-dark-mode.nvim",
  dependencies = { "Mofiqul/vscode.nvim" },
  lazy = false,
  priority = 999, -- right after the colorscheme
  opts = {
    set_dark_mode = function()
      vim.o.background = "dark"
      vim.cmd.colorscheme("vscode")
    end,
    set_light_mode = function()
      vim.o.background = "light"
      vim.cmd.colorscheme("vscode")
    end,
    update_interval = 3000,
  },
}
