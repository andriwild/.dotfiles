return {
  'chomosuke/typst-preview.nvim',
  -- lazy = false, -- or ft = 'typst'
  ft = 'typst',
  version = '1.*',
  opts = {
    }, -- lazy.nvim will implicitly calls `setup {}`

    config = function ()
        local tp = require("typst-preview")
        tp.setup({})
    end
}
