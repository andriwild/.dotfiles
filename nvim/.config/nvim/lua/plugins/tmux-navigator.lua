return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  keys = {
    { "<C-h>", "<cmd>TmuxNavigateLeft<CR>", desc = "Navigate window left" },
    { "<C-j>", "<cmd>TmuxNavigateDown<CR>", desc = "Navigate window down" },
    { "<C-k>", "<cmd>TmuxNavigateUp<CR>", desc = "Navigate window up" },
    { "<C-l>", "<cmd>TmuxNavigateRight<CR>", desc = "Navigate window right" },
    { "<C-\\>", "<cmd>TmuxNavigatePrevious<CR>", desc = "Navigate to previous window" },
  },
}
