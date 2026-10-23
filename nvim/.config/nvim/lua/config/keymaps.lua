-- Global keymaps. Plugin-specific ones live next to their plugin spec.
local map = vim.keymap.set

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Leave terminal mode
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Move selected lines, keeping indentation
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Hover docs in a float; without an LSP, notify instead of opening keywordprg (pydoc, man) in a buffer
map("n", "K", function()
  if #vim.lsp.get_clients({ bufnr = 0, method = "textDocument/hover" }) > 0 then
    vim.lsp.buf.hover()
  else
    vim.notify("No language server with hover support for this buffer", vim.log.levels.INFO)
  end
end, { desc = "Hover documentation" })

-- Join lines without moving the cursor
map("n", "J", "mzJ`z", { desc = "Join lines, keep cursor" })

-- Keep the cursor centered while jumping
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up and center" })
map("n", "n", "nzzzv", { desc = "Next search match and center" })
map("n", "N", "Nzzzv", { desc = "Previous search match and center" })

-- Clipboard
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
map("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })
map("x", "<leader>p", [["_dP]], { desc = "Paste without yanking selection" })

-- Location list
map("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next location list item" })
map("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Previous location list item" })

-- Quickfix list
map("n", "[q", "<cmd>cprevious<CR>zz", { desc = "Previous quickfix item" })
map("n", "]q", "<cmd>cnext<CR>zz", { desc = "Next quickfix item" })

-- Replace the word under the cursor across the buffer
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Substitute word under cursor" })

-- Toggle light/dark manually (auto-dark-mode still follows macOS)
map("n", "<leader>'", function()
  vim.o.background = vim.o.background == "dark" and "light" or "dark"
  vim.cmd.colorscheme("vscode")
end, { desc = "Toggle light/dark theme" })

-- Buffers
map("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })

-- tmux
map("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer.sh<CR>", { desc = "tmux sessionizer" })
