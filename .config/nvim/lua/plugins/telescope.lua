return {
  'nvim-telescope/telescope.nvim', tag = '0.1.5',
  dependencies = {
    -- ui-select sets enables vim.ui.select to telescope
    'nvim-telescope/telescope-ui-select.nvim',
    'nvim-lua/plenary.nvim',
  },


  -- config = function()
  --   local telescope = require('telescope')
  --   local actions = require('telescope.actions')
  --   local action_state = require('telescope.actions.state')
  --   local builtin = require('telescope.builtin')
  --   local themes = require('telescope.themes')

  --   -- sends either all files, or if files are selected, all selected files to qf list
  --   local smart_send_to_qflist = function(prompt_bufnr)
  --       local picker = action_state.get_current_picker(prompt_bufnr)
  --       local multi_selection = picker:get_multi_selection()

  --       if #multi_selection > 0 then
  --           -- only send selected
  --           actions.send_selected_to_qflist(prompt_bufnr)
  --       else
  --           -- send all files
  --           actions.send_to_qflist(prompt_bufnr)
  --       end
  --       actions.open_qflist(prompt_bufnr)
  --   end


  --   telescope.setup({
  --     extensions = {
  --       ['ui-select'] = {
  --         themes.get_dropdown {
  --           -- even more opts
  --         }
  --       }
  --     },
  --     defaults = {
  --       file_ignore_patterns = { 'elm-stuff', 'node_modules', '.git' },
  --       mappings = {
  --         i = {
  --           ["<C-q>"] = smart_send_to_qflist,  -- für Insert-Modus
  --         },
  --         n = {
  --           ["<C-q>"] = smart_send_to_qflist,  -- für Normal-Modus
  --         },
  --       },
  --     }
  --   })

  --   telescope.load_extension('ui-select')

  --   -- indicates whether hidden files should be shown
  keys = {
    {
      "<leader>sf",
      function() require("telescope.builtin").find_files({}) end,
      desc = "Find File",
    },
    {
      "<leader>ss",
      function() require("telescope.builtin").lsp_document_symbols() end,
      desc = "Find LSP Symbol",
    },
    {
      "<leader>ws",
      function() require("telescope.builtin").lsp_workspace_symbols() end,
      desc = "Find LSP Workspace Symbol",
    },
    {
      "<leader>g",
      function() require("telescope.builtin").git_files() end,
      desc = "Find Git File",
    },
    {
      "<leader>sh",
      function() require("telescope.builtin").help_tags() end,
      desc = "Search Help Tag",
    },
    {
      "<leader>sw",
      function() require("telescope.builtin").grep_string() end,
      desc = "Search Word",
    },
    {
      "<leader>sg",
      function() require("telescope.builtin").live_grep({hidden = false}) end,
      desc = "Live Grep String",
    },
    {
      "<leader>sd",
      function() require("telescope.builtin").diagnostics() end,
      desc = "Search Diagnostics",
    },
    {
      "<leader>x",
      function() require("telescope.builtin").current_buffer_fuzzy_find(
        require('telescope.themes').get_dropdown{
          winblend = 10,
          previewer = false
        }
        )
      end,
      desc = "Fuzzily search in current buffer",
    },
    {
      "<leader>v",
      function() require("telescope.builtin").treesitter() end,
      desc = "Treesitter",
    },
  }


  --   vim.keymap.set('n', '<leader>hf', function()
  --     hidden = not hidden
  --     print("Show hidden files: " .. tostring(hidden))
  --   end, { desc = 'Swap search [H]idden [F]iles' })
}
