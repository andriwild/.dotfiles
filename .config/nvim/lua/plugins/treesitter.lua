return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup {
      -- A list of parser names, or "all"
      ensure_installed = { "python", "kotlin", "java", "javascript", "typescript", "c", "lua", "rust", "elm" }, -- langugages are syntax highlighted

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      auto_install = true,
      indent = {
        enable = true,
        disable = { 'python', 'c'}
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<c-space>',
          node_incremental = '<c-space>',
          scope_incremental = '<c-s>',
          node_decremental = '<c-backspace>',
        }
      },

      highlight = {
        -- `false` will disable the whole extension
        enable = true,
        disable = { "latex" },
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      }
    }
 end
}
