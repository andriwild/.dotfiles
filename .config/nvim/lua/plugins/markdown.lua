return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "echasnovski/mini.nvim",
  },

  opts = {},

  config = function()
    local md = require("render-markdown")

    md.setup({
      code = {
        enabled = true,
        background = {
          highlight = "RDMdCodeBg",
        },
      },

      bullet = {
        right_pad = 1,
      },
    })
  end,
}

