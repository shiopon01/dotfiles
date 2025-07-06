-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- ここまで定型文

-- フォントサイズ
config.font_size = 12.2
config.font = wezterm.font('JetBrains Mono', { italic = false })
-- 背景の非透過率（1なら完全に透過させない）
config.window_background_opacity = 0.90

-- キーバインド
config.keys = {
    -- タブ
    {
        key = 'c',
        mods = 'CMD|CTRL',
        action = wezterm.action.SpawnTab 'CurrentPaneDomain',
    },
    {
        key = 'k',
        mods = 'CMD|CTRL',
        action = wezterm.action.CloseCurrentTab { confirm = true },
    },
    -- タブ移動
    {
        key = 'n',
        mods = 'CMD|CTRL',
        action = wezterm.action.ActivateTabRelative(1),
    },
    {
        key = 'p',
        mods = 'CMD|CTRL',
        action = wezterm.action.ActivateTabRelative(-1),
    },
    -- ペイン
    {
        key = ",",
        mods = "CMD|CTRL",
        action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } },
    },
    {
        key = ".",
        mods = "CMD|CTRL",
        action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } },
    },
    {
        key = 'x',
        mods = 'CMD|CTRL',
        action = wezterm.action.CloseCurrentPane { confirm = true },
    },
    -- ペイン移動
    {
        key = 'o',
        mods = 'CMD|CTRL',
        action = wezterm.action.ActivatePaneDirection 'Next',
    },
    -- ⌘ Ctrl Shift hjkl でペイン境界の調整
    {
        key = 'h',
        mods = 'CMD|CTRL|SHIFT',
        action = wezterm.action.AdjustPaneSize { 'Left', 2 },
    },
    {
        key = 'j',
        mods = 'CMD|CTRL|SHIFT',
        action = wezterm.action.AdjustPaneSize { 'Down', 2 },
    },
    {
        key = 'k',
        mods = 'CMD|CTRL|SHIFT',
        action = wezterm.action.AdjustPaneSize { 'Up', 2 },
    },
    {
        key = 'l',
        mods = 'CMD|CTRL|SHIFT',
        action = wezterm.action.AdjustPaneSize { 'Right', 2 },
    },

    -- ランチャー表示
    {
        key = "l",
        mods = "ALT|CTRL",
        action = wezterm.action.ShowLauncher,
    }
}

return config
