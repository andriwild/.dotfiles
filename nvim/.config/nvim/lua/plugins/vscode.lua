return {
  "Mofiqul/vscode.nvim",
  priority = 1000, -- load before other plugins so highlights are in place
  opts = {
    -- Light/dark follows `vim.o.background`, which auto-dark-mode.nvim flips.
    italic_comments = true,
    underline_links = true,
    disable_nvimtree_bg = true,
    group_overrides = {
      -- Only the editor area is transparent, so Ghostty's background shows
      -- through and the seam between terminal and editor disappears. Floats
      -- and popups keep their own background so they stay readable.
      Normal = { bg = "NONE" },
      NormalNC = { bg = "NONE" },
    },
  },
  config = function(_, opts)
    require("vscode").setup(opts)
    vim.cmd.colorscheme("vscode")
  end,
}
