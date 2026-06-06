--
-- PATH is handled by UWSM via xdg.configFile."uwsm/env" in default.nix
-- (sources home-manager's hm-session-vars.sh, which includes
-- home.sessionPath additions like ~/.local/bin).

hl.config({
    env = {
        -- Hyprcursor (primary for Wayland / server-side cursor apps)
        "HYPRCURSOR_THEME,rose-pine-hyprcursor",
        "HYPRCURSOR_SIZE,24",

        -- XCursor fallback (GTK and other legacy cursor apps)
        "XCURSOR_THEME,BreezeX-RosePine-Linux",
        "XCURSOR_SIZE,24",
    },
})
