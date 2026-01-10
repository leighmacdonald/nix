{
  hyprland,
  hy3,
  pkgs,
  config,
  ...
}:
{
  imports = [
    hyprland.homeManagerModules.default
  ];
  xdg = {
    configFile."uwsm/env".source =
      "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
    portal = {
      extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
    };
  };
  wayland = {
    windowManager.hyprland = {
      enable = true;
      systemd = {
        enable = false; # conflicts with UWSM.
        variables = [ "--all" ];
      };
      # package = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      # portalPackage = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      package = null;
      portalPackage = null;
      plugins = [ hy3.packages.x86_64-linux.hy3 ];
      settings = {
        #$terminal = runapp kitty
        "$terminal" = "ghostty +new-window";
        "$fileManager" = "thunar";
        "$menu" = "rofi -show drun -show-icons";
        #exec-once = "runapp hyprpm reload -n";

        monitor = [
          "HDMI-A-1,2560x1440@59.95,1120x680,1.0"
          "HDMI-A-1,transform,3"
          "DP-1,2560x1440@59.95,6400x680,1.0"
          "DP-1,transform,1"
          "DP-2,3840x2160@144.0,2560x1080,1.0"
          "DP-3,1920x1080@119.98,3507x0,1.0"
        ];
        ecosystem = {
          enforce_permissions = false;
        };

        permission = [
          "/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland, screencopy, allow"
          "/usr/bin/(grim|hyprpicker), screencopy, allow"
          #"/usr/(bin|local/bin)/hyprpm, plugin, allow"
          #permission = .*, plugin, allow
        ];

        # https://wiki.hypr.land/Configuring/Variables/#general
        general = {
          gaps_in = 0;
          gaps_out = 0;
          border_size = 2;

          # https://wiki.hypr.land/Configuring/Variables/#variable-types for info about colors
          #col.active_border = "$sapphire";
          #col.inactive_border = "$base";

          # Set to true enable resizing windows by clicking and dragging on borders and gaps
          resize_on_border = true;

          # Please see https://wiki.hypr.land/Configuring/Tearing/ before you turn this on
          allow_tearing = false;

          layout = "dwindle";
          #layout = "hy3";
        };

        # https://wiki.hypr.land/Configuring/Variables/#decoration
        decoration = {
          rounding = 0;
          rounding_power = 2;

          # Change transparency of focused and unfocused windows
          active_opacity = 1.0;
          inactive_opacity = 1.0;

          shadow = {
            enabled = false;
            range = 4;
            render_power = 3;
            #color = "rgba(1a1a1aee)";
          };

          # https://wiki.hypr.land/Configuring/Variables/#blur
          blur = {
            enabled = false;
            size = 3;
            passes = 1;
            vibrancy = 0.1696;
          };
        };

        animations = {
          enabled = false;
        };

        dwindle = {
          pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = true; # You probably want this
        };

        master = {
          new_status = "master";
        };

        misc = {
          force_default_wallpaper = 0; # Set to 0 or 1 to disable the anime mascot wallpapers
          disable_hyprland_logo = true; # If true disables the random hyprland logo / anime girl background. :(
        };

        input = {
          kb_layout = "us";
          kb_options = "caps:none";
          follow_mouse = 1;
          sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
          touchpad = {
            natural_scroll = false;
          };
        };

        device = {
          name = "epic-mouse-v1";
          sensitivity = -0.5;
        };

        "$mainMod" = "SUPER"; # Sets "Windows" key as main modifier

        bind = [
          "$mainMod, return, exec, $terminal"
          #"$mainMod, Q, hy3:killactive,"
          "$mainMod, Q, killactive,"
          "$mainMod, M, exec, command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"
          # bind = $mainMod, M, exec, uwsm stop
          "$mainMod, E, exec, $fileManager"
          "$mainMod, SPACE, togglefloating,"
          "$mainMod, d, exec, $menu"
          "$mainMod, C, exec, hyprpicker -a -f hex -l"
          "$mainMod, P, pseudo," # dwindle
          "$mainMod, J, togglesplit, " # dwindle
          "$mainMod SHIFT, S, exec, grim -g \"$(slurp -d)\" - | wl-copy"
          "$mainMod, f, fullscreen"

          # Move focus with mainMod + arrow keys
          #"$mainMod, left, hy3:movefocus, l"
          #"$mainMod, right, hy3:movefocus, r"
          #"$mainMod, up, hy3:movefocus, u"
          #"$mainMod, down, hy3:movefocus, d"

          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"

          #$moveWindow = exec /home/leigh/.config/hypr/movewindow.sh

          "$mainMod SHIFT, left, exec, $moveWindow"
          "$mainMod SHIFT, rigth, exec, $moveWindow"
          "$mainMod SHIFT, up, exec, $moveWindow"
          "$mainMod SHIFT, down, exec, $moveWindow"

          #"$mainMod SHIFT, left, hy3:movewindow, left"
          #"$mainMod SHIFT, right, hy3:movewindow, right"
          #"$mainMod SHIFT, up, hy3:movewindow, up"
          #"$mainMod SHIFT, down, hy3:movewindow, down"

          "$mainMod ctrl, right, resizeactive, 50 0"
          "$mainMod ctrl, left, resizeactive, -50 0"
          "$mainMod ctrl, up, resizeactive, 0 -50"
          "$mainMod ctrl, down, resizeactive, 0 50"

          # Switch workspaces with mainMod + [0-9]
          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"

          # Move active window to a workspace with mainMod + SHIFT + [0-9]
          #"$mainMod SHIFT, 1, hy3:movetoworkspace, 1"
          #"$mainMod SHIFT, 2, hy3:movetoworkspace, 2"
          #"$mainMod SHIFT, 3, hy3:movetoworkspace, 3"
          #"$mainMod SHIFT, 4, hy3:movetoworkspace, 4"

          #"$mainMod, t, hy3:makegroup, tab, toggle"

          # Scroll through existing workspaces with mainMod + scroll
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
          "$mainMod, Escape, workspace, previous"
        ];

        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];

        # Enable workspace cycling
        binds = {
          allow_workspace_cycles = true;
        };

        # Laptop multimedia keys for volume and LCD brightness
        bindel = [
          ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
          ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ];

        # Requires playerctl
        bindl = [
          ", XF86AudioNext, exec, playerctl -p mpd next"
          ", XF86AudioPause, exec, playerctl -p mpd play-pause"
          ", XF86AudioPlay, exec, playerctl -p mpd play-pause"
          ", XF86AudioPrev, exec, playerctl -p mpd previous"
        ];

        # Ignore maximize requests from apps. You'll probably like this.
        #windowrule = [
        #  "suppressevent maximize, class:.*"
        #  # Fix some dragging issues with XWayland
        #  "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        #];
        # fix tooltips (always have a title of `win.<id>`)
        #windowrule {
        #    # Ignore maximize requests from all apps. You'll probably like this.
        #    name = suppress-maximize-events
        #    match:class = .*
        #
        #    suppress_event = maximize
        #}
        #
        #windowrule {
        #    # Fix some dragging issues with XWayland
        #    name = fix-xwayland-drags
        #    match:class = ^$
        #    match:title = ^$
        #    match:xwayland = true
        #    match:float = true
        #    match:fullscreen = false
        #    match:pin = false
        #
        #    no_focus = true
        #}

        workspace = [
          "1, monitor:HDMI-A-1, persistent:true, defaultName:left, on-created-empty:firefox"
          "2, monitor:DP-2, persistent:true, defaultName:main, default:true, on-created-empty:zeditor"
          "3, monitor:DP-1, persistent:true, defaultName:right, on-created-empty:vesktop"
          "4, monitor:DP-3, persistent:true, defaultName:top, on-created-empty:keepassxc"
        ];
      };
    };
  };
}
