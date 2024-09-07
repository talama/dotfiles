-- wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()

config.font = wezterm.font("JetBrainsMono NF")
config.font_size = 12
config.line_height = 1.1
config.adjust_window_size_when_changing_font_size = false

config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_padding = {
	bottom = 0,
	left = 0,
}

config.color_scheme = "Catppuccin Macchiato"
config.window_background_opacity = 1

config.use_dead_keys = false
config.scrollback_lines = 5000

config.keys = {
	{ key = "-", mods = "CTRL|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "|", mods = "CTRL|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "h", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Left") },
	{ key = "l", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Right") },
	{ key = "k", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Up") },
	{ key = "j", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Down") },
	{ key = "x", mods = "CTRL|SHIFT", action = act.CloseCurrentPane({ confirm = false }) },
	{ key = "t", mods = "CTRL|SHIFT", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "w", mods = "CTRL|SHIFT", action = act.CloseCurrentTab({ confirm = false }) },
}

return config
