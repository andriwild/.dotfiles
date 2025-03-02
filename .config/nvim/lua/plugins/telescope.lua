return {
  'nvim-telescope/telescope.nvim', tag = '0.1.5',
  dependencies = {
    'nvim-telescope/telescope-ui-select.nvim',
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local builtin = require('telescope.builtin')

    -- Telescope setup
    require('telescope').setup({
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
          },
        },
        file_ignore_patterns = { "node_modules", ".git/" },
        path_display = { "truncate" },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown {}
        }
      }
    })

    -- Load the ui-select extension
    require("telescope").load_extension("ui-select")

    -- Set up keybindings
    vim.keymap.set('n', '<leader>sf', function() builtin.find_files({}) end, { desc = "Find File" })
    vim.keymap.set('n', '<leader>ss', function() builtin.lsp_document_symbols() end, { desc = "Find LSP Symbol" })
    vim.keymap.set('n', '<leader>ws', function() builtin.lsp_workspace_symbols() end, { desc = "Find LSP Workspace Symbol" })
    vim.keymap.set('n', '<leader>g', function() builtin.git_files() end, { desc = "Find Git File" })
    vim.keymap.set('n', '<leader>sh', function() builtin.help_tags() end, { desc = "Search Help Tag" })
    vim.keymap.set('n', '<leader>sw', function() builtin.grep_string() end, { desc = "Search Word" })
    vim.keymap.set('n', '<leader>sg', function() builtin.live_grep({hidden = false}) end, { desc = "Live Grep String" })
    vim.keymap.set('n', '<leader>sd', function() builtin.diagnostics() end, { desc = "Search Diagnostics" })
    vim.keymap.set('n', '<leader>x', function()
      builtin.current_buffer_fuzzy_find(
        require('telescope.themes').get_dropdown{
          winblend = 10,
          previewer = false
        }
      )
    end, { desc = "Fuzzily search in current buffer" })
    vim.keymap.set('n', '<leader>v', function() builtin.treesitter() end, { desc = "Treesitter" })

    -- Add the spell suggest binding
    vim.keymap.set('n', '<leader>zz', builtin.spell_suggest, { desc = 'Spell suggest' })
  end,
  -- Define keys for lazy loading
  keys = {
    { "<leader>sf", desc = "Find File" },
    { "<leader>ss", desc = "Find LSP Symbol" },
    { "<leader>ws", desc = "Find LSP Workspace Symbol" },
    { "<leader>g", desc = "Find Git File" },
    { "<leader>sh", desc = "Search Help Tag" },
    { "<leader>sw", desc = "Search Word" },
    { "<leader>sg", desc = "Live Grep String" },
    { "<leader>sd", desc = "Search Diagnostics" },
    { "<leader>x", desc = "Fuzzily search in current buffer" },
    { "<leader>v", desc = "Treesitter" },
    { "<leader>zz", desc = "Spell suggest" },
  }
}
