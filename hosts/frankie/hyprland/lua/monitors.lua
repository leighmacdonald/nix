hl.monitor({
    output    = "HDMI-A-1",
    mode      = "2560x1440@59.95",
    position  = "1120x680",
    scale     = "1.0",
    transform = 3
})
hl.workspace_rule({
    workspace = "1",
    monitor = "HDMI-A-1",
    persistent = true,
    default_name = "left",
    on_created_empty = "firefox"
})

hl.monitor({
    output    = "DP-1",
    mode      = "2560x1440@59.95",
    position  = "1120x680",
    scale     = "1.0",
    transform = 1
})
hl.workspace_rule({
    workspace = "2",
    monitor = "DP-2",
    persistent = true,
    default_name = "main",
    -- on_created_empty = "zeditor"
})

hl.monitor({
    output   = "DP-2",
    mode     = "3840x2160@144.0",
    position = "2560x1080",
    scale    = "1.0",
})
hl.workspace_rule({
    workspace = "3",
    monitor = "DP-2",
    persistent = true,
    default_name = "right",
    on_created_empty = "discord"
})

hl.monitor({
    output   = "DP-3",
    mode     = "1920x1080@119.98",
    position = "3507x0",
    scale    = "1.0",
})
hl.workspace_rule({
    workspace = "4",
    monitor = "DP-2",
    persistent = true,
    default_name = "top",
    on_created_empty = "keepassxc"
})
