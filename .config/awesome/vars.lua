local awful = require("awful")
local beautiful = require("beautiful")

local vars = {}

vars.terminal = "kitty"
vars.editor = "nvim"
vars.editor_cmd = vars.terminal .. "-e" .. vars.editor

-- Themes define colours, icons, font and wallpapers.
path = "/home/masacaai/.config/awesome/themes/"
theme = "default"
beautiful.init(path .. theme .. ".lua")


-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
return vars
