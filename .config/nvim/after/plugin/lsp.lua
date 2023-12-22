local lsp = require("lsp-zero")

lsp.preset("recommended")

--lsp.ensure_installed({
--  'tsserver',
--  'eslint',
--  'rust_analyzer',
--  --'sumneko_lua',
--})

lsp.configure('hls', {
		 --cmd = {"/home/andri/.ghcup/bin/haskell-language-server-2.2.0.0", "--lsp"}
		--cmd = {"/home/andri/.ghcup/bin/haskell-language-server-wrapper-1.9.1.0", "--lsp"}
		cmd = {"/home/andri/.ghcup/hls/2.2.0.0/lib/haskell-language-server-2.2.0.0/bin/haskell-language-server-wrapper", "--lsp"}
})

vim.g.zig_fmt_autosave = 0;

--Fix Undefined global 'vim'
<<<<<<< Updated upstream
--lsp.configure('lua-language-server', {
--    settings = {
--        Lua = {
--            diagnostics = {
--                globals = { 'vim' }
--            }
--        }
--    }
--})
-- require'lspconfig'.pylsp.setup{
--   settings = {
--     pylsp = {
--       plugins = {
--         pycodestyle = {
--           ignore = {'W391'},
--           maxLineLength = 100
--         }
--       }
--     }
--   }
-- }

lsp.configure('pylsp', {
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = {'W391', 'E402'},
          maxLineLength = 200
        }
      }
    }
  }
})

lsp.configure('arduino_language_server', {
    cmd = {
        "arduino-language-server",
--        "-cli-config", "/home/austin/.arduino15/arduino-cli.yaml",
--        "-fqbn", "esp32:esp32:featheresp32",
       -- "-cli", "/usr/bin/arduino-cli",
        -- "-clangd", "/usr/bin/clangd"
    }
})

  local cmp = require('cmp')
  local cmp_action = require('lsp-zero').cmp_action()

  cmp.setup({
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
      ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
      ['<Enter>'] = cmp.mapping.confirm({ select = true }),
      ["<C-Space>"] = cmp.mapping.complete(),
    })
  })

--local cmp = require('cmp')
--local cmp_select = {behavior = cmp.SelectBehavior.Select}
--local cmp_mappings = lsp.defaults.cmp_mappings({
--  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
--  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
--  ['<Enter>'] = cmp.mapping.confirm({ select = true }),
--  ["<C-Space>"] = cmp.mapping.complete(),
--})

-- disable completion with tab
-- this helps with copilot setup
-- cmp_mappings['<Tab>'] = nil
-- cmp_mappings['<S-Tab>'] = nil

-- lsp.setup_nvim_cmp({
--   mapping = cmp_mappings
-- })

lsp.set_preferences({
--	sign_icons = { }
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  if client.name == "eslint" then
      vim.cmd.LspStop('eslint')
      return
  end

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set("n", "<leader>3", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "<leader>2", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "<leader>1", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
  vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set({"n", "v"}, "<leader><CR>", vim.lsp.buf.code_action, opts)
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
})
