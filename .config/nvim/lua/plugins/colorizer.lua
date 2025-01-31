return {
  "norcalli/nvim-colorizer.lua",
  lazy = false,
  name = "colorizer",

  config = function ()
    local color = require("colorizer")
    color.setup()
  end
}
