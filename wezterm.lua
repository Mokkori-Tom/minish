local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.automatically_reload_config = true
config.window_close_confirmation = "NeverPrompt"
config.default_cursor_style = "BlinkingBar"

config.font = wezterm.font("HackGen Console NF")
config.font_size = 18.0

config.window_decorations = "RESIZE"
config.window_background_opacity = 0.7

config.colors = {
  foreground = '#ffffff',
  background = '#1e1e1e',
  cursor_bg = '#ffcc00',
  cursor_fg = '#000000',
  cursor_border = '#ffcc00',
  selection_fg = '#ffffff',
  selection_bg = '#007acc',
  ansi = { '#000000', '#ff5555', '#50fa7b', '#f1fa8c', '#bd93f9', '#ff79c6', '#8be9fd', '#ffffff' },
  brights = { '#4d4d4d', '#ff6e6e', '#69ff94', '#ffffa5', '#d6acff', '#ff92df', '#a4ffff', '#ffffff' },
}

config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false
config.default_prog = { "./minish" }

config.front_end = "OpenGL"
config.webgpu_power_preference = "HighPerformance"

config.keys = {
  -- Vertical split (Ctrl-d)
  {
    key = "d",
    mods = "CTRL",
    action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
  },
  -- Horizontal split (Ctrl-s)
  {
    key = "s",
    mods = "CTRL",
    action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
  },
  -- Move focus (Ctrl-h/j/k/l, Vim style)
  {
    key = "h",
    mods = "CTRL",
    action = wezterm.action.ActivatePaneDirection "Left",
  },
  {
    key = "l",
    mods = "CTRL",
    action = wezterm.action.ActivatePaneDirection "Right",
  },
  {
    key = "k",
    mods = "CTRL",
    action = wezterm.action.ActivatePaneDirection "Up",
  },
  {
    key = "j",
    mods = "CTRL",
    action = wezterm.action.ActivatePaneDirection "Down",
  },
}

return config
