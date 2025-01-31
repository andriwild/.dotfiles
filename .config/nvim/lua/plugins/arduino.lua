return {'sudar/vim-arduino-syntax'}
-- return {
--     "glebzlat/arduino-nvim",
--     config = function ()
--         local arduino = require("arduino-nvim")
--         arduino.setup({
--             filetype = "arduino",
--         })
--     end
-- }


-- require("arduino-nvim").setup {
--   default_fqbn = "arduino:avr:uno",
--   clangd = nil|string, -- path to a clangd executable
--   arduino = nil|string, -- path to a arduino-cli executable
--   extra_args = nil|table, -- command line args to arduino lsp
--   root_dir = nil|string,
--   capabilities = nil
--   filetypes = {"arduino"},
--   callbacks = {
--     on_attach = nil|function(client, bufnr)
--   }
-- }
