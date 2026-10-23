return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- Load at startup when nvim is opened on a directory (`vi .`) so the tree
  -- replaces netrw there; otherwise stay lazy.
  lazy = not (vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1),
  init = function()
    if vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end
  end,
  cmd = { "NvimTreeToggle", "NvimTreeFindFileToggle", "NvimTreeFocus" },
  keys = {
    {
      "<leader>t",
      function()
        vim.cmd.NvimTreeToggle()
        vim.cmd("wincmd p") -- keep the cursor in the editor window
      end,
      desc = "Toggle file explorer",
    },
    { "<leader>pv", "<cmd>NvimTreeFocus<CR>", desc = "Focus file explorer" },
    { "<leader>T", "<cmd>NvimTreeFindFileToggle<CR>", desc = "Reveal current file in explorer" },
  },
  opts = {
    on_attach = function(bufnr)
      require("nvim-tree.api").config.mappings.default_on_attach(bufnr)
      -- Default <C-k> shows file info; free it for window navigation.
      vim.keymap.del("n", "<C-k>", { buffer = bufnr })
    end,
    view = { width = 34 },
    renderer = { group_empty = true },
    filters = { dotfiles = false, custom = { "^.git$" } },
    update_focused_file = { enable = true },
  },
}
