return {
  dir = "/home/andri/repos/smart-indent",
  keys = {
    {
      "<leader>h",
      ":SmartIndent<CR>",
      mode = "x",
      silent = true,
      desc = "smart-indent: align selection",
    },
  },
  cmd = "SmartIndent",
  opts = { keymap = false },
}
