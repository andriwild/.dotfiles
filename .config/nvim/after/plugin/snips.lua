vim.cmd([[call nvimhs#start('/home/andri/repos/snips-nvim/', 'snips', [])]])

vim.keymap.set("n", "<F5>",
function()
  vim.cmd([[ call nvimhs#compileAndRestart('snips') ]])
  print("recompiled")
end
)

