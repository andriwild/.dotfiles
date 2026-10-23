return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  cmd = { "ClaudeCode", "ClaudeCodeFocus", "ClaudeCodeSend", "ClaudeCodeAdd" },
  keys = {
    { "<leader>a", nil, desc = "Claude Code" },
    { "<leader>ac", "<cmd>ClaudeCode<CR>", desc = "Toggle Claude Code" },
    { "<leader>af", "<cmd>ClaudeCodeFocus<CR>", desc = "Focus Claude Code" },
    { "<leader>ab", "<cmd>ClaudeCodeAdd %<CR>", desc = "Add current buffer to context" },
    { "<leader>as", "<cmd>ClaudeCodeSend<CR>", mode = "v", desc = "Send selection to Claude Code" },
    {
      "<leader>as",
      "<cmd>ClaudeCodeTreeAdd<CR>",
      ft = { "NvimTree" },
      desc = "Add file under cursor to context",
    },
    { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<CR>", desc = "Accept Claude Code diff" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<CR>", desc = "Deny Claude Code diff" },
  },
  opts = {},
}
