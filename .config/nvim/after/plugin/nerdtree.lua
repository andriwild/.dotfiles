-- vim.keymap.set("n","<leader>pv", vim.cmd.NERDTreeToggle)
-- vim.keymap.set("n","<leader>nn", vim.cmd.NERDTreeFocus)
vim.keymap.set("n","<leader>nf", vim.cmd.NERDTreeFind)

vim.keymap.set("n","<leader>pt", function() 
  vim.cmd.NERDTreeToggle()
  vim.cmd("wincmd p")
end)

vim.keymap.set("n","<leader>pf", function()
  vim.cmd.NERDTreeFind()
  vim.cmd("wincmd p")
end)
