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
