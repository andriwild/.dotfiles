local gears         = require("gears")
local awful         = require("awful")
local wibox         = require("wibox")
local beautiful     = require("beautiful")

-- ### Pavlov Widgets ###
-- ### https://pavelmakhov.com/awesome-wm-widgets/
local battery_widget    = require("awesome-wm-widgets.battery-widget.battery")
local volume_widget     = require('awesome-wm-widgets.volume-widget.volume')
local brightness_widget = require("awesome-wm-widgets.brightness-widget.brightness")


-- {{{ Wibar
-- Create a textclock widget
textClock = wibox.widget.textclock()
textClock.format = "%H:%M"
textClockWidget = wibox.container.margin(textClock, 5, 10, 0, 0)

-- Keyboard map indicator and switcher
-- mykeyboardlayout = awful.widget.keyboardlayout()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
        awful.button({ }, 1, function(t) t:view_only() end),
        awful.button({ modkey }, 1, function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end),
        awful.button({ }, 3, awful.tag.viewtoggle),
        awful.button({ modkey }, 3, function(t)
            if client.focus then
                client.focus:toggle_tag(t)
            end
        end),
        awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
        awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)


awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)
    -- Each screen has its own tag table.
    awful.tag(beautiful.tagIcons, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
            awful.button({ }, 1, function () awful.layout.inc( 1) end),
            awful.button({ }, 3, function () awful.layout.inc(-1) end),
            awful.button({ }, 4, function () awful.layout.inc( 1) end),
            awful.button({ }, 5, function () awful.layout.inc(-1) end)))

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        style = {
            spacing = 10,
            font = "JetBrains Mono 16"
        }
    }

	beautiful.systray_icon_spacing = 10

    local systrayContainer = wibox.widget {
			{
					{
						widget = wibox.widget.systray()
				    },
					layout = wibox.layout.fixed.horizontal
			},
			widget = wibox.container.margin,
			margins = 6,
			right = 20
	}


    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            --mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
			systrayContainer,
            spacing = 5,
            volume_widget {
                widget_type = 'arc',
                thickness = 1,
            },
            battery_widget{},
            brightness_widget {
                type = 'arc',
                program = 'brightnessctl',
                step = 2,
                base = 80,
            },
            textClockWidget,
            --s.mylayoutbox,
        },
    }
end)
-- }}}
