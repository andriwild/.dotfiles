return {
    "VonHeikemen/lsp-zero.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets",
    },


    config = function()
        local notify = vim.notify
        vim.notify = function(msg, ...)
            if msg:match("lspconfig.*deprecated") then return end
            notify(msg, ...)
        end

        local lsp = require("lsp-zero")
        local lspconfig = require("lspconfig")

        lsp.extend_lspconfig()

        local function switch_source_header(bufnr)
            vim.lsp.buf_request(bufnr, "textDocument/switchSourceHeader", { uri = vim.uri_from_bufnr(bufnr) }, function(err, result)
                if err then
                    vim.notify(tostring(err), vim.log.levels.ERROR)
                    return
                end
                if not result or result == "" then
                    vim.notify("clangd: keine zugehörige Datei gefunden", vim.log.levels.WARN)
                    return
                end
                vim.cmd.edit(vim.uri_to_fname(result))
            end)
        end

        lsp.on_attach(function(client, bufnr)
            local opts = { buffer = bufnr, remap = false }
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            if client.name == "clangd" then
                vim.keymap.set("n", "<leader>oh", function() switch_source_header(bufnr) end, opts)
            end
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
            vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
            vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
            vim.keymap.set("n", "<leader>2", vim.diagnostic.goto_next, opts)
            vim.keymap.set("n", "<leader>3", vim.diagnostic.goto_prev, opts)
            vim.keymap.set({ "n", "v" }, "<leader><CR>", vim.lsp.buf.code_action, opts)
            vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
            vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
            vim.keymap.set("n", "<leader>gd", function()
                vim.cmd("wincmd v")
                vim.lsp.buf.definition()
            end, { noremap = true, silent = true })
        end)


        vim.diagnostic.config({
            virtual_text = true,
            signs = true,
            update_in_insert = false,
            underline = true,
            severity_sort = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "single",
                source = "always",
                header = "",
                prefix = "",
            },
        })

        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
            vim.lsp.handlers.hover, {
                border = "rounded",
                title = " Documentation "
            }
        )

        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
            vim.lsp.handlers.signature_help, {
                border = "rounded",
                close_events = { "BufHidden", "InsertLeave" },
            }
        )

        lsp.ui({
            float_border = "rounded",
            sign_text = { error = "✘", warn = "▲", hint = "⚑", info = "»" },
        })

        require("mason").setup({})
        require("mason-lspconfig").setup({
            ensure_installed = { "tinymist", "lua_ls", "eslint" },
            handlers = {
                lsp.default_setup,

                lua_ls = function()
                    lspconfig.lua_ls.setup({
                        settings = {
                            Lua = { diagnostics = { globals = { "vim" } } },
                        },
                    })
                end,

                eslint = function()
                    lspconfig.eslint.setup({
                        on_attach = function(client, bufnr)
                            vim.api.nvim_create_autocmd("BufWritePre", {
                                buffer = bufnr,
                                command = "EslintFixAll",
                            })
                        end,
                    })
                end,

                tinymist = function()
                    lspconfig.tinymist.setup({
                        offset_encoding = "utf-8",
                        settings = {
                            formatterMode = "typstyle",
                            exportPdf = "onSave",
                        },
                        on_attach = function(client, bufnr)
                            local root_dir = client.config.root_dir or vim.fn.getcwd()
                            local mainFile = root_dir .. "/thesis.typ"
                            
                            -- Pcall nutzen, falls der Befehl fehlschlägt
                            pcall(function() 
                                vim.lsp.buf.execute_command({
                                    command = "tinymist.pinMain",
                                    arguments = { mainFile },
                                })
                            end)

                            local opts = { buffer = bufnr, remap = false }
                            vim.keymap.set("n", "<leader>rr", function()
                                local current = vim.fn.bufnr("%")
                                vim.cmd("e " .. mainFile)
                                vim.cmd.TypstPreview()
                                vim.cmd("buffer " .. current)
                            end, opts)

                            vim.keymap.set("n", "<leader>rc", function()
                                local current = vim.fn.bufnr("%")
                                vim.cmd("e " .. mainFile)
                                vim.cmd.TypstPreviewStop()
                                vim.cmd("buffer " .. current)
                            end, opts)
                        end,
                    })
                end,
            },
        })

        local cmp = require("cmp")
        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            sources = {
                { name = "path" },
                { name = "nvim_lsp" },
                { name = "nvim_lua" },
                { name = "luasnip", keyword_length = 2 },
                { name = "buffer", keyword_length = 3 },
            },
            formatting = lsp.cmp_format(),
            mapping = cmp.mapping.preset.insert({
                ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                ["<Enter>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Enter>"] = cmp.mapping.complete(),
                ["<Tab>"] = cmp.config.disable,
            }),
        })
    end,
}
