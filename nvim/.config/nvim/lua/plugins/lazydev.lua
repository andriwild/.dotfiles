return {
  "folke/lazydev.nvim",
  ft = "lua",
  opts = {
    library = {
      -- Load the full Neovim API types when a buffer references vim.uv
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  },
}
