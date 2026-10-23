-- Add a server by giving it an entry here, then install its binary with `:Mason`.
-- Keys are nvim-lspconfig server names; values override the shipped config.
local servers = {
  lua_ls = {
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
        -- stylua formats Lua through conform.nvim
        format = { enable = false },
      },
    },
  },
  basedpyright = {
    -- Treat a directory with a .venv as project root, alongside the shipped markers
    root_markers = { "pyrightconfig.json", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".venv", ".git" },
    -- Use the project's .venv even when nvim wasn't started from an activated shell
    before_init = function(_, config)
      local python = config.root_dir and vim.fs.joinpath(config.root_dir, ".venv", "bin", "python")
      if python and vim.uv.fs_stat(python) then
        config.settings = vim.tbl_deep_extend("force", config.settings or {}, { python = { pythonPath = python } })
      end
    end,
  },
}

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    { "mason-org/mason-lspconfig.nvim", opts = { ensure_installed = {}, automatic_enable = false } },
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    -- Advertise nvim-cmp's completion capabilities to every server
    vim.lsp.config("*", {
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
    })

    for name, config in pairs(servers) do
      vim.lsp.config(name, config)
    end
    vim.lsp.enable(vim.tbl_keys(servers))

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp_attach", { clear = true }),
      callback = function(args)
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, desc = desc })
        end

        map("n", "gd", vim.lsp.buf.definition, "Go to definition")
        map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
        map("n", "gr", vim.lsp.buf.references, "Go to references")
        map("n", "<leader>r", vim.lsp.buf.rename, "Rename symbol")
        map({ "n", "v" }, "<leader><CR>", vim.lsp.buf.code_action, "Code action")
        map("n", "<leader>vd", vim.diagnostic.open_float, "Show line diagnostics")
        map("n", "<leader>vws", vim.lsp.buf.workspace_symbol, "Workspace symbol")
        map("n", "<leader>vrr", vim.lsp.buf.references, "List references")
        map("n", "<leader>2", function()
          vim.diagnostic.jump({ count = 1, float = true })
        end, "Next diagnostic")
        map("n", "<leader>3", function()
          vim.diagnostic.jump({ count = -1, float = true })
        end, "Previous diagnostic")
        -- Open the definition in a vertical split
        map("n", "<leader>gd", function()
          vim.cmd("wincmd v")
          vim.lsp.buf.definition()
        end, "Go to definition in split")
      end,
    })
  end,
}
