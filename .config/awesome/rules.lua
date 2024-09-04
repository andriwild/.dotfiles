local awful = require("awful")
local beautiful = require("beautiful")

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
      }
    },

    -- floating clients.
    { rule_any = {
        instance = {
            "dta",  -- firefox addon downthemall.
            "copyq",  -- includes session name in class.
            "pinentry",
        },
        class = {
            "arandr",
            "blueman-manager",
            "gpick",
            "awmtt",
            "kruler",
            "messagewin",  -- kalarm.
            "sxiv",
            "tor browser", -- needs a fixed window size to avoid fingerprinting by screen size.
            "wpa_gui",
            "veromix",
			"starter",
            "xtightvncviewer"},

        -- note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
            "event tester",  -- xev.
        },
        role = {
            "alarmwindow",  -- thunderbird's calendar.
            "configmanager",  -- thunderbird's about:config.
            "pop-up",       -- e.g. google chrome's (detached) developer tools.
        }
    }, properties = { floating = true }},

    -- add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
    }, properties = { titlebars_enabled = true }
    },

    -- set firefox to always map on the tag named "2" on screen 1.

    { rule = { instance = "chromium" },
      properties = { tag = beautiful.tagicons[1] } },

    { rule = { class = "firefox" },
      properties = { tag = beautiful.tagicons[1], floating = false, maximized = false } },

    { rule = { instance = "nemo" },
      properties = { tag = beautiful.tagicons[4] } },

--     { rule = { instance = "idea" },
--       properties = { tag = beautiful.tagicons[2] } },

    { rule = { instance = "alacritty" },
      properties = { opacity = 0.9} },
}
-- }}}
