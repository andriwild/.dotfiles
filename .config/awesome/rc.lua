-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

require("awful.hotkeys_popup.keys") -- Enable hotkeys help widget for VIM and other apps
require("awful.autofocus")

local awful         = require("awful")
local gears         = require("gears")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
local configPath    = gears.filesystem.get_configuration_dir()

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- modkey = "Mod4"

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(configPath .. "themes/default/theme.lua")
beautiful.get().wallpaper = "/home/andri/.config/awesome/themes/wallpaper/wood-wallpaper.jpg"

-- }}}

dofile(configPath .. "logger.lua")
dofile(configPath .. "menu.lua")
dofile(configPath .. "layout.lua")
dofile(configPath .. "taglist.lua")
dofile(configPath .. "bindings/mouse_bindings.lua")
dofile(configPath .. "bindings/global_key_bindings.lua")
dofile(configPath .. "bindings/client_key_bindings.lua")
dofile(configPath .. "bindings/global_tag_key_bindings.lua")
dofile(configPath .. "rules.lua")
dofile(configPath .. "signal.lua")

-- Set keys
root.keys(globalkeys)

awful.spawn.with_shell("/home/andri/init.sh")
