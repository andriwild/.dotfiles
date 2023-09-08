local awful     = require("awful")
local menubar   = require("menubar")
local beautiful = require("beautiful")
local constants = require("constants")

local terminal = constants.terminal

editor = os.getenv("EDITOR") or "vi"
editor_cmd = terminal .. " -e " .. editor

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
    { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "manual", terminal .. " -e man awesome" },
    { "edit config", editor_cmd .. " " .. awesome.conffile },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end },
}

monitor_menu = {
  { "Home", function() awful.spawn.with_shell(".screenlayout/home.sh") end},
  { "Work", function() awful.spawn.with_shell(".screenlayout/work.sh") end}
}

mymainmenu = awful.menu({ items = { 
  { "Awesome", myawesomemenu, beautiful.awesome_icon },
  { "Monitor", monitor_menu}
}
})

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}
