return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  opts = {
    options = {
      theme = "vscode",
      globalstatus = true,
      section_separators = "",
      component_separators = "|",
    },
    sections = {
      lualine_c = { { "filename", path = 1 } },
      lualine_x = { "diagnostics", "filetype" },
    },
  },
}
