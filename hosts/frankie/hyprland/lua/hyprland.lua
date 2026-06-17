local hy3 = hl.plugin.hy3
local HOME = os.getenv("HOME")
local PUBLIC = "/projects/nix/hosts/frankie/hyprland/lua"
local XDG = os.getenv("XDG_CONFIG_HOME") or (HOME .. "/.config")

package.path = package.path
    .. ";" .. PUBLIC .. "/?.lua"
    .. ";" .. XDG .. "/hypr" .. "/?.lua"

hl.config({
    ecosystem = {
        enforce_permissions = false,
    },
})

hl.exec_cmd("/projects/nix/load_hy3.sh");

-- 2hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
hl.config({
    plugin = {
        hy3 = {
            tab_first_window = false,
            autotile = {
                enable = true,
            },
            tabs = {
                height = 32,
                padding = 0,
                radius = 0,
                border_width = 1,
                text_font = "JetBrainsMono Nerd Font",
                text_height = 16,
                text_padding = 3,

                blur = true,
                opacity = 1.0,

                -- col {
                --     active = "rgb(${config.lib.stylix.colors.base00})",
                --     "active.border" = "rgb(${config.lib.stylix.colors.base00})",
                --     "active.text" = "rgb(${config.lib.stylix.colors.base0B})",
                --     -- "col.active.text" = "rgba(ffffffff)",

                --     -- active tab bar segment colors for bars on an unfocused monitor
                --     "active_alt_monitor" = "rgba(60606040)",
                --     "active_alt_monitor.border" = "rgba(808080ee)",
                --     "active_alt_monitor.text" = "rgba(ffffffff)",

                --     -- focused tab bar segment colors (focused node in unfocused container)
                --     "focused" = "rgba(60606040)",
                --     "focused.border" = "rgba(808080ee)",
                --     "focused.text" = "rgba(ffffffff)",

                --     -- inactive tab bar segment colors
                --     "inactive" = "rgb(${config.lib.stylix.colors.base00})",
                --     "inactive.border" = "rgb(${config.lib.stylix.colors.base00})",
                --     "inactive.text" = "rgba(ffffffff)",

                --     -- urgent tab bar segment colors
                --     "urgent" = "rgba(ff223340)",
                --     "urgent.border" = "rgba(ff2233ee)",
                --     "urgent.text" = "rgba(ffffffff)",

                --     -- urgent tab bar segment colors
                --     "locked" = "rgba(90903340)",
                --     "locked.border" = "rgba(909033ee)",
                --     "locked.text" = "rgba(ffffffff)",
                -- }
            }
        }
    }
})


--
-- PATH is handled by UWSM via xdg.configFile."uwsm/env" in default.nix
-- (sources home-manager's hm-session-vars.sh, which includes
-- home.sessionPath additions like ~/.local/bin).

hl.config({
    env = {
        "XDG_CURRENT_DESKTOP,Hyprland",
        "XDG_SESSION_TYPE,wayland",
        "XDG_SESSION_DESKTOP,Hyprland",
        -- Hyprcursor (primary for Wayland / server-side cursor apps)
        "HYPRCURSOR_THEME,rose-pine-hyprcursor",
        "HYPRCURSOR_SIZE,24",

        -- XCursor fallback (GTK and other legacy cursor apps)
        "XCURSOR_THEME,BreezeX-RosePine-Linux",
        "XCURSOR_SIZE,24",
        "GDK_BACKEND,wayland,x11",
        "MOZ_ENABLE_WAYLAND,1",
        "OZONE_PLATFORM,wayland"
    },
})

---------------
---- INPUT ----
---------------
hl.config({
    input = {
        kb_layout     = "us",
        kb_variant    = "",
        kb_model      = "",
        kb_options    = "caps:none",
        kb_rules      = "",

        follow_mouse  = 1,
        accel_profile = "linear",
        sensitivity   = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad      = {
            natural_scroll = false,
        },
    },
})

-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in          = 0,
        gaps_out         = 0,

        border_size      = 2,

        col              = {
            active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing    = false,

        layout           = "hy3",
    },

    decoration = {
        rounding         = 0,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow           = {
            enabled = false,
        },

        blur             = {
            enabled = false,
        },
    },

    animations = {
        enabled = false,
    },
})

hl.config({
    misc = {
        force_default_wallpaper = 0,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = true, -- If true disables the random hyprland logo / anime girl background. :(
    },
})

hl.monitor({
    output    = "HDMI-A-1",
    mode      = "2560x1440@59.95",
    position  = "1120x680",
    scale     = "1.0",
    transform = 3
})


hl.monitor({
    output    = "DP-1",
    mode      = "2560x1440@59.95",
    position  = "6400x680",
    scale     = "1.0",
    transform = 1
})
-- mid
hl.monitor({
    output   = "DP-2",
    mode     = "3840x2160@144.0",
    position = "2560x1080",
    scale    = "1.0",
})
-- top
hl.monitor({
    output   = "DP-3",
    mode     = "1920x1080@119.98",
    position = "3507x0",
    scale    = "1.0",
})

hl.workspace_rule({
    workspace = "1",
    monitor = "HDMI-A-1",
    persistent = true,
    default_name = "left",
    on_created_empty = "firefox"
})
hl.workspace_rule({
    workspace = "2",
    monitor = "DP-2",
    persistent = true,
    default_name = "main",
    -- on_created_empty = "zeditor"
})
hl.workspace_rule({
    workspace = "3",
    monitor = "DP-2",
    persistent = true,
    default_name = "right",
    on_created_empty = "discord"
})
hl.workspace_rule({
    workspace = "4",
    monitor = "DP-3",
    persistent = true,
    default_name = "top",
    on_created_empty = "keepassxc"
})

---------------------
---- KEYBINDINGS ----
---------------------
local terminal    = "ghostty +new-window"
local fileManager = "thunar"
local menu        = "rofi -show drun -show-icons"
local screenshot  = "grim -g \"$(slurp -d)\" - | wl-copy"
local mainMod     = "SUPER"

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + return", hl.dsp.exec_cmd(terminal))

hl.bind(mainMod .. " + M",
    hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + SPACE", hl.dsp.layout("togglefloating"))
hl.bind(mainMod .. " + d", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle only
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(screenshot))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + q", hl.dsp.exec_cmd("killactive"))

hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())

hl.bind(mainMod .. " + SHIFT + X", hl.dsp.exec_cmd("exit"))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
-- for i = 1, 10 do
--     local key = i % 10 -- 10 maps to key 0
--     hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
--     hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
-- end

-- Example special workspace (scratchpad)
-- hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
-- hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(mainMod .. " + left", hy3.move_focus("l"))
hl.bind(mainMod .. " + right", hy3.move_focus("r"))
hl.bind(mainMod .. " + up", hy3.move_focus("u"))
hl.bind(mainMod .. " + down", hy3.move_focus("d"))


hl.bind(mainMod .. " + SHIFT + left", hy3.move_window("l"))
hl.bind(mainMod .. " + SHIFT + right", hy3.move_window("r"))
hl.bind(mainMod .. " + SHIFT + up", hy3.move_window("u"))
hl.bind(mainMod .. " + SHIFT + down", hy3.move_window("d"))

local resizeUnit = 50
hl.bind(mainMod .. " + CTRL + left", hl.dsp.window.resize({ x = resizeUnit, y = 0, relative = true }))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.resize({ x = -resizeUnit, y = 0, relative = true }))
hl.bind(mainMod .. " + CTRL + up", hl.dsp.window.resize({ x = 0, y = -resizeUnit, relative = true }))
hl.bind(mainMod .. " + CTRL + down", hl.dsp.window.resize({ x = 0, y = resizeUnit, relative = true }))


hl.bind(mainMod .. " + SHIFT + T", hy3.make_group("tab"))

hl.config({
    binds = {
        drag_threshold = 10 -- Fire a drag event only after dragging for more than 10px
    }
})

hl.bind("ALT + mouse:272", hl.dsp.window.drag(), { mouse = true, drag = true })   -- ALT + LMB (drag): Move a window by dragging more than 10px.
hl.bind("ALT + mouse:272", hl.dsp.window.float(), { mouse = true, click = true }) -- ALT + LMB (click): Floats a window by clicking

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })


-- hl.bind("SUPER + F10", hl.dsp.pass({ window = "class:^(com\\.obsproject\\.Studio)$" }))

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

hl.bind("mouse:276",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle & pw-play /projects/nix/discord-notification.mp3"),
    { locked = true, repeating = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name           = "suppress-maximize-events",
    match          = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name     = "fix-xwayland-drags",
    match    = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

hl.on("hyprland.start", function()
    hl.dispatch(hl.dsp.focus({ workspace = 1 }))
    -- hl.exec_cmd("uwsm app -- pypr")
    hl.exec_cmd("xrandr --output DP-2 --primary")
    hl.exec_cmd("systemctl --user start hyperpolkitagent")
    hl.exec_cmd("steam")
end)

hl.on("config.reloaded", function()
    hl.exec_cmd("pypr reload")
end)

hl.animation({ leaf = "global", enabled = false })
