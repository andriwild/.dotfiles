--return {
--  "catppuccin/nvim",
--  lazy = true,
--  name = "catppuccin",
--  opts = {
--    integrations = {
--      aerial = true,
--      alpha = true,
--      cmp = true,
--      dashboard = true,
--      flash = true,
--      gitsigns = true,
--      headlines = true,
--      illuminate = true,
--      indent_blankline = { enabled = true },
--      leap = true,
--      lsp_trouble = true,
--      mason = true,
--      markdown = true,
--      mini = true,
--      native_lsp = {
--        enabled = true,
--        underlines = {
--          errors = { "undercurl" },
--          hints = { "undercurl" },
--          warnings = { "undercurl" },
--          information = { "undercurl" },
--        },
--      },
--      navic = { enabled = true, custom_bg = "lualine" },
--      neotest = true,
--      neotree = true,
--      noice = true,
--      notify = true,
--      semantic_tokens = true,
--      telescope = true,
--      treesitter = true,
--      treesitter_context = true,
--      which_key = true,
--    },
--  },
--}
--

return {
  "rose-pine/neovim",
  name = "rose-pine",
  lazy = false,
  config = function ()
    local scheme = require("rose-pine")
    scheme.setup({
	highlight_groups = {
        colorcolumn = { bg = "highlight_low"},
	},
  })
  end
}
