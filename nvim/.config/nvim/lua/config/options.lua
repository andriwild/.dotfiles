local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.termguicolors = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false
opt.winborder = "rounded"
opt.splitright = true
opt.splitbelow = true

-- Indentation
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- Files: no swap/backup, persistent undo instead
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.updatetime = 250

-- Editing
opt.clipboard = "unnamedplus"
opt.mouse = "a"
opt.completeopt = { "menu", "menuone", "noselect" }
opt.inccommand = "split"

-- Show trailing whitespace and tabs
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Disable unused remote-plugin providers (nothing installed here needs them)
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- Diagnostics: inline virtual text plus rounded float borders
vim.diagnostic.config({
  -- One dot per line instead of one per diagnostic, with a count when there are several
  virtual_text = {
    prefix = function(_, i, total)
      if i < total then
        return ""
      end
      return total > 1 and ("● " .. total) or "●"
    end,
  },
  severity_sort = true,
  float = { border = "rounded", source = true },
})

-- Briefly highlight text on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
