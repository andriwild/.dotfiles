-- `require` happens inside the callbacks so the plugin stays lazy-loaded
-- until a harpoon key is actually pressed.
local function list()
  return require("harpoon"):list()
end

local keys = {
  {
    "<leader>ha",
    function()
      list():add()
    end,
    desc = "Harpoon add file",
  },
  {
    "<leader>hh",
    function()
      local harpoon = require("harpoon")
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end,
    desc = "Harpoon quick menu",
  },
}

-- Direct jumps to the first four marks
for i = 1, 4 do
  table.insert(keys, {
    "<leader>h" .. i,
    function()
      list():select(i)
    end,
    desc = "Harpoon jump to file " .. i,
  })
end

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = keys,
  config = function()
    require("harpoon"):setup()
  end,
}
