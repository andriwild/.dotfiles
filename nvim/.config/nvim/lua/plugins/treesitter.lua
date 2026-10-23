-- nvim-treesitter `main` branch: it only installs parsers/queries; highlighting
-- itself comes from Neovim (`vim.treesitter.start`).
local ensure_installed = {
  "lua",
  "vim",
  "vimdoc",
  "query",
  "markdown",
  "markdown_inline",
  "bash",
  "json",
  "yaml",
  "toml",
}

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false, -- this branch does not support lazy-loading
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")
    ts.setup()
    ts.install(ensure_installed)

    local available = {}
    for _, lang in ipairs(ts.get_available()) do
      available[lang] = true
    end

    -- Start highlighting for any buffer whose parser exists, installing it on
    -- first encounter (the `auto_install` behaviour of the old branch).
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match) or args.match
        if not available[lang] then
          return
        end
        if vim.list_contains(ts.get_installed(), lang) then
          pcall(vim.treesitter.start, args.buf, lang)
          return
        end
        ts.install({ lang }):await(function(err)
          if not err and vim.api.nvim_buf_is_valid(args.buf) then
            pcall(vim.treesitter.start, args.buf, lang)
          end
        end)
      end,
    })
  end,
}
