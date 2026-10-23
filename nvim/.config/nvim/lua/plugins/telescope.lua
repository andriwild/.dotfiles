return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
  },
  keys = {
    { "<leader>sf", "<cmd>Telescope find_files<CR>", desc = "Find file" },
    { "<leader>sg", "<cmd>Telescope live_grep<CR>", desc = "Live grep string" },
    { "<leader>sw", "<cmd>Telescope grep_string<CR>", desc = "Search word under cursor" },
    { "<leader>sh", "<cmd>Telescope help_tags<CR>", desc = "Search help tags" },
    { "<leader>sd", "<cmd>Telescope diagnostics<CR>", desc = "Search diagnostics" },
    { "<leader>ss", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Find LSP symbol" },
    { "<leader>ws", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", desc = "Find LSP workspace symbol" },
    { "<leader>g", "<cmd>Telescope git_files<CR>", desc = "Find git file" },
    { "<leader>km", "<cmd>Telescope keymaps<CR>", desc = "Search keymaps" },
    { "<leader>v", "<cmd>Telescope treesitter<CR>", desc = "Treesitter symbols" },
    { "<leader>zz", "<cmd>Telescope spell_suggest<CR>", desc = "Spell suggest" },
    {
      "<leader>x",
      function()
        require("telescope.builtin").current_buffer_fuzzy_find(
          require("telescope.themes").get_dropdown({ winblend = 10, previewer = false })
        )
      end,
      desc = "Fuzzily search in current buffer",
    },
  },
  opts = {
    defaults = {
      path_display = { "truncate" },
      mappings = {
        i = {
          ["<C-j>"] = "move_selection_next",
          ["<C-k>"] = "move_selection_previous",
        },
      },
    },
    pickers = {
      find_files = { hidden = true },
    },
    extensions = {
      ["ui-select"] = {},
    },
  },
  config = function(_, opts)
    local telescope = require("telescope")
    opts.extensions["ui-select"] = { require("telescope.themes").get_dropdown() }
    telescope.setup(opts)
    telescope.load_extension("ui-select")
  end,
}
