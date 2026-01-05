local wezterm = require 'wezterm'
local config = {}

-- Show which key table is active in the status area
wezterm.on("update-right-status", function(window, pane)
  local name = window:active_key_table()
  if name then
    name = "TABLE: " .. name
  end
  window:set_right_status(name or "")
end)


-- キーバインド
return {
  -- NOTE: tmuxで使っていた設定の移植
  keys = {
    -- タブ
    {
        key = 'c',
        mods = 'META|CTRL',
        action = wezterm.action.SpawnTab 'CurrentPaneDomain',
    },
    {
        key = 'k',
        mods = 'META|CTRL',
        action = wezterm.action.CloseCurrentTab { confirm = true },
    },
    -- タブ移動
    {
        key = 'n',
        mods = 'META|CTRL',
        action = wezterm.action.ActivateTabRelative(1),
    },
    {
        key = 'p',
        mods = 'META|CTRL',
        action = wezterm.action.ActivateTabRelative(-1),
    },
    -- ペイン
    {
        key = ",",
        mods = 'META|CTRL',
        action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } },
    },
    {
        key = ".",
        mods = 'META|CTRL',
        action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } },
    },
    {
        key = 'x',
        mods = 'META|CTRL',
        action = wezterm.action.CloseCurrentPane { confirm = true },
    },
    -- ペイン移動
    {
        key = 'o',
        mods = 'META|CTRL',
        action = wezterm.action.ActivatePaneDirection 'Next',
    },
    -- ⌘ Ctrl Shift hjkl でペイン境界の調整
    {
        key = 'h',
        mods = 'META|CTRL|SHIFT',
        action = wezterm.action.AdjustPaneSize { 'Left', 2 },
    },
    {
        key = 'j',
        mods = 'META|CTRL|SHIFT',
        action = wezterm.action.AdjustPaneSize { 'Down', 2 },
    },
    {
        key = 'k',
        mods = 'META|CTRL|SHIFT',
        action = wezterm.action.AdjustPaneSize { 'Up', 2 },
    },
    {
        key = 'l',
        mods = 'META|CTRL|SHIFT',
        action = wezterm.action.AdjustPaneSize { 'Right', 2 },
    },

    -- ランチャー表示
    {
        key = "l",
        mods = "ALT|CTRL",
        action = wezterm.action.ShowLauncher,
    },
  },
}
