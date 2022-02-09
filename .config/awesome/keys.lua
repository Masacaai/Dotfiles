local awful = require("awful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup")
local vars = require("vars")

local keys = {}

alt = "Mod1"
win = "Mod4"

-- {{{{{{{{{{{}}}}}}}}}}}
-- {{{ Mouse bindings }}}
-- {{{{{{{{{{{}}}}}}}}}}}

root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

-- {{{{{{{{{{}}}}}}}}}}
-- {{{ Key bindings }}}
-- {{{{{{{{{{}}}}}}}}}}

keys.globalkeys = gears.table.join(
    
    awful.key({ win,           }, "s",      
        hotkeys_popup.show_help,
        {description="show help", group="awesome"}),
    
    awful.key({ alt,           }, "Left",   
        awful.tag.viewprev,
        {description = "view previous", group = "tag"}),
    
    awful.key({ alt,           }, "Right",  
        awful.tag.viewnext,
        {description = "view next", group = "tag"}),
    
    awful.key({ alt,           }, "Escape", 
        awful.tag.history.restore,
        {description = "go back", group = "tag"}),

    awful.key({ alt,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}),
    
    awful.key({ alt,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}),
    
    awful.key({ win,           }, "w", 
        function () 
	    mymainmenu:show() 
        end,
        {description = "show main menu", group = "awesome"}),
    
    -------------------------
    -- Layout manipulation --
    -------------------------

    awful.key({ alt, "Shift"   }, "j", 
        function () 
	    awful.client.swap.byidx(  1)    
        end,
        {description = "swap with next client by index", group = "client"}),
    
    awful.key({ alt, "Shift"   }, "k", 
        function () 
	    awful.client.swap.byidx( -1)    
        end,
        {description = "swap with previous client by index", group = "client"}),
    
    awful.key({ alt, "Control" }, "j", 
        function () 
	    awful.screen.focus_relative( 1) 
        end,
        {description = "focus the next screen", group = "screen"}),
    
    awful.key({ alt, "Control" }, "k", 
        function () 
	    awful.screen.focus_relative(-1) 
        end,
        {description = "focus the previous screen", group = "screen"}),
    
    awful.key({ alt,           }, "u", 
        awful.client.urgent.jumpto,
        {description = "jump to urgent client", group = "client"}),
    
    awful.key({ alt,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),
    
    -----------------------
    -- Standard programs --
    -----------------------
    
    awful.key({ alt,           }, "Return", 
        function () 
	    awful.spawn(vars.terminal) 
        end,
        {description = "open a terminal", group = "launcher"}),
    
    awful.key({ alt, "Shift" }, "r", 
        awesome.restart,
        {description = "reload awesome", group = "awesome"}),
    
    awful.key({ alt, "Shift"   }, "e", 
        awesome.quit,
        {description = "quit awesome", group = "awesome"}),

    awful.key({ alt,           }, "l",     
        function () 
	    awful.tag.incmwfact( 0.05)          
        end,
        {description = "increase master width factor", group = "layout"}),
    
    awful.key({ alt,           }, "h",     
        function () 
	    awful.tag.incmwfact(-0.05)          
        end,
        {description = "decrease master width factor", group = "layout"}),

    awful.key({ alt, "Shift"   }, "h",     
        function () 
	    awful.tag.incnmaster( 1, nil, true) 
        end,
        {description = "increase the number of master clients", group = "layout"}),
    
    awful.key({ alt, "Shift"   }, "l",     
        function () 
            awful.tag.incnmaster(-1, nil, true) 
        end,
        {description = "decrease the number of master clients", group = "layout"}),
    
    awful.key({ alt, "Control" }, "h",     
        function () 
	    awful.tag.incncol( 1, nil, true)    
        end,
        {description = "increase the number of columns", group = "layout"}),
    
    awful.key({ alt, "Control" }, "l",     
        function () 
	    awful.tag.incncol(-1, nil, true)    
        end,
        {description = "decrease the number of columns", group = "layout"}),
    
    awful.key({ alt,           }, "space", 
        function () 
	    awful.layout.inc( 1)                
        end,
        {description = "select next", group = "layout"}),
    
    awful.key({ alt, "Shift"   }, "space", 
        function () 
	    awful.layout.inc(-1)                
        end,
        {description = "select previous", group = "layout"}),

    awful.key({ alt, "Control" }, "n",
        function ()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                c:emit_signal(
                    "request::activate", "key.unminimize", {raise = true}
                )
            end
        end,
        {description = "restore minimized", group = "client"}),

    ------------
    -- Prompt --
    ------------

--    awful.key({ win,           }, "r",     
--        function () 
--	    awful.screen.focused().mypromptbox:run() 
--        end,
--        {description = "run prompt", group = "launcher"}),

    awful.key({ alt,           }, "x",
        function ()
	    awful.prompt.run {
                prompt       = "Run Lua code: ",
                textbox      = awful.screen.focused().mypromptbox.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. "/history_eval"
              }
        end,
        {description = "lua execute prompt", group = "awesome"}),
    
    -------------
    -- Menubar --
    -------------

    awful.key({ win,           }, "p", 
        function() 
	    menubar.show() 
        end,
        {description = "show the menubar", group = "launcher"}),


    -----------------
    -- Custom keys --
    -----------------

    -- Volume Keys
   
    awful.key({                 }, "XF86AudioLowerVolume", 
        function ()
            awful.spawn("pamixer -d 10", false)
        end,
	{description = "Lower volume", group = "system"}),

    awful.key({                 }, "XF86AudioRaiseVolume", 
        function ()
            awful.spawn("pamixer -i 10", false)
        end,
	{description = "Raise volume", group = "system"}),
   
    awful.key({                 }, "XF86AudioMute", 
        function ()
            awful.spawn("pamixer -t", false)
        end,
	{description = "Mute audio", group = "system"}),

    -- Media Keys
    
    awful.key({                 }, "XF86AudioPlay", 
        function()
            awful.spawn("playerctl play-pause", false)
        end,
	{description = "Play/Pause audio", group = "system"}),
   
    awful.key({                 }, "XF86AudioNext", 
        function()
            awful.spawn("playerctl next", false)
        end,
	{description = "Play next", group = "system"}),

    awful.key({                 }, "XF86AudioPrev", 
        function()
            awful.spawn("playerctl previous", false)
        end,
	{description = "Play previous", group = "system"}),

    -- Brightness keys --

    awful.key({                 }, "XF86MonBrightnessUp",
        function()
	    awful.spawn("xbacklight -inc 10", false)
	end,
	{description = "Increase brightness", group = "system"}),
    
    awful.key({                 }, "XF86MonBrightnessDown",
        function()
            awful.spawn("xbacklight -dec 10", false)
        end,
        {description = "Decrease brightness", group = "system"}),
       
    awful.key({ alt,            }, "w",
        function()
            awful.spawn("qutebrowser")
	end,
	{description = "launch qutebrowser", group = "apps"}),

    awful.key({ alt,            }, "b",
        function ()
            myscreen = awful.screen.focused()
            myscreen.mywibox.visible = not myscreen.mywibox.visible
        end,
        {description = "toggle statusbar", group = "awesome"}),

    awful.key({ alt,            }, "p",
        function()
	    awful.spawn("pcmanfm")
	end,
	{description = "Launch PCManFM", group = "apps"}),

    awful.key({ alt,            }, "f",
        function()
            awful.spawn("firefox")
        end,
        {description = "Launch Firefox", group = "apps"}),

    awful.key({ alt,            }, "r",
        function()
            awful.spawn( vars.terminal .. "-e ranger")
        end,
        {description = "Launch Ranger", group = "apps"}),

    awful.key({ alt,            }, "Print",
        function()
            awful.spawn("/home/masacaai/.scripts/maim/sc.sh")
        end,
        {description = "Desktop screenshot", group = "launcher"}),

    awful.key({                 }, "Print",
        function()
            awful.spawn("/home/masacaai/.scripts/maim/scs.sh")
        end,
        {description = "Area screenshot", group = "launcher"}),

    awful.key({ alt, "Control"  }, "x",
        function()
            awful.spawn("xkill")
        end,
        {description = "Launch xkill", group = "apps"}),

    awful.key({ alt,            }, "backslash",
        function()
	    awful.spawn("code")
	end,
	{description = "Launch VSCode", group = "apps"}),

    awful.key({ alt,            }, "s",
        function()
            awful.spawn("signal-desktop")
        end,
        {description = "Launch Signal", group = "apps"}),

    awful.key({ alt,            }, "v",
        function()
            awful.spawn(vars.terminal .. "-e" .. vars.editor)
        end,
        {description = "Launch Neovim", group = "apps"}),

    awful.key({ win,            }, "n",
        function()
            awful.spawn(vars.terminal ..  "-e newsboat")
        end,
        {description = "Launch Newsboat", group = "apps"}),

    awful.key({ win,            }, "v",
        function()
            awful.spawn("VirtualBox")
        end,
        {description = "Launch VirtualBox", group = "apps"}),

    awful.key({ win,            }, "t",
        function()
            awful.spawn("urxvt -e ssh masacaai@tilde.club")
        end,
        {description = "Launch Tilde.Club", group = "launcher"}),

    awful.key({ win,            }, "c",
        function()
            awful.spawn( vars.terminal .. "-e ranger .config/awesome")
        end,
        {description = "Open config directory", group = "launcher"}),

    awful.key({ win,            }, "r",
        function()
            awful.spawn("rofi -show run")
        end,
        {description = "Launch Rofi", group = "launcher"}),

    awful.key({ alt,            }, "y",
        function()
            awful.spawn(vars.terminal .. "-e ytfzf -t")
        end,
        {description = "Launch YTfzf", group = "apps"}),

    awful.key({ win,            }, "l",
        function()
	    awful.spawn("dm-tool switch-to-greeter")
	end,
	{description = "Lock screen", group = "system"})
)

keys.clientkeys = gears.table.join(
    
    awful.key({ win,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    
    awful.key({ alt,           }, "q",      
        function (c) 
	    c:kill()                         
        end,
        {description = "close", group = "client"}),
    
    awful.key({ alt, "Control" }, "space",  
        awful.client.floating.toggle                     ,
        {description = "toggle floating", group = "client"}),
    
    awful.key({ alt, "Control" }, "Return", 
        function (c) 
	    c:swap(awful.client.getmaster()) 
        end,
        {description = "move to master", group = "client"}),
    
    awful.key({ alt,           }, "o",      
        function (c) 
	    c:move_to_screen()               
        end,
        {description = "move to screen", group = "client"}),
    
    awful.key({ win,           }, "t",      
        function (c) 
            c.ontop = not c.ontop            
        end,
        {description = "toggle keep on top", group = "client"}),

    awful.key({ alt,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    
    awful.key({ alt,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    
    awful.key({ alt, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    
    awful.key({ alt, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 10 do
    keys.globalkeys = gears.table.join(keys.globalkeys,
        -- View tag only.
        awful.key({ alt }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ alt, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ alt, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ alt, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

keys.clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ alt }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ alt }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(keys.globalkeys)
-- }}}

return keys
