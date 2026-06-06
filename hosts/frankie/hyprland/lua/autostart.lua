-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
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
