{
  pkgs,
  pkgsUnstable,
  inputs,
  config,
  lib,
  ...
}:
let
  osd_display = "DP-3";
  osd_player = "mpd";
in
{
  services.swayosd = {
    enable = true;
    # OSD Margin from the top edge, 0.5 would be the screen center. May be from 0.0 - 1.0.
    topMargin = 0.9;
    # For a custom stylesheet file.
    #stylePath = "/etc/xdg/swayosd/style.css";
  };
  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
    x11 = {
      enable = true;
      defaultCursor = "Adwaita";
    };

    sway.enable = true;
  };
  stylix.targets.sway = {
    enable = true;
  };
  wayland.windowManager.sway = {
    package = pkgsUnstable.sway;
    systemd = {
      enable = true;
      xdgAutostart = true;
      variables = [ "--all" ];
    };
    enable = true;
    checkConfig = false;
    wrapperFeatures.gtk = true; # Fixes common issues with GTK 3 apps
    # extraConfig = ''
    #   no_focus [class="^tf_linux*"]
    # '';
    config = {
      bars = [ ];
      modifier = "Mod4";
      menu = "rofi -show drun -show-icons";
      terminal = "foot";
      window = {
        border = 1;
        titlebar = false;
        hideEdgeBorders = "smart_no_gaps";
        # commands = [
        #   {
        #     command = "floating enable";
        #     criteria = {
        #       class = "tf_linux64";
        #     };
        #   }
        # ];
      };
      keycodebindings = lib.mkOptionDefault {
        "275" =
          "exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle & pw-play ${inputs.self}/discord-notification.mp3";
      };
      keybindings =
        let
          modifier = config.wayland.windowManager.sway.config.modifier;
        in
        lib.mkOptionDefault {
          "${modifier}+Shift+e" = "exec uwsm stop";
          "${modifier}+Shift+s" = "grim -g \"$(slurp -d)\" - | wl-copy";
          "XF86AudioRaiseVolume" = "exec swayosd-client --monitor ${osd_display} --output-volume raise";
          "XF86AudioLowerVolume" = "exec swayosd-client --monitor ${osd_display} --output-volume lower";
          "XF86AudioMute" = "exec swayosd-client --monitor ${osd_display} --output-volume mute-toggle";
          "XF86AudioMicMute" = "exec swayosd-client --monitor ${osd_display} --input-volume mute-toggle";
          "XF86AudioPlay" =
            "exec swayosd-client --monitor ${osd_display} --player=${osd_player} --playerctl play-pause";
          "XF86AudioNext" =
            "exec swayosd-client --monitor ${osd_display} --player=${osd_player} --playerctl next";
          "XF86AudioPrev" =
            "exec swayosd-client --monitor ${osd_display} --player=${osd_player} --playerctl prev";
        };
      input = {
        "type:pointer" = {
          accel_profile = "flat";
          pointer_accel = "0";
        };
      };

      output = {
        "DP-1" = {
          mode = "2560x1440@59.95Hz";
          pos = "6400 680";
          scale = "1.0";
          transform = "270";
          bg = "${inputs.self}/wallpaper/pillars-vertical-4k.jpg fill";
        };
        "HDMI-A-1" = {
          mode = "2560x1440@59.95Hz";
          pos = "1120 680";
          scale = "1.0";
          transform = "90";
          bg = "${inputs.self}/wallpaper/pillars-vertical-4k.jpg fill";
        };
        "DP-2" = {
          mode = "3840x2160@144.0Hz";
          position = "2560 1080";
          scale = "1.0";
          bg = "${inputs.self}/wallpaper/wp8280844-nasa-4k-wallpapers.jpg fill";
        };
        "DP-3" = {
          mode = "1920x1080@119.98Hz";
          position = "3507 0";
          scale = "1.0";
          bg = "${inputs.self}/wallpaper/RosetteNebula-1080.png fill";
        };
      };
      workspaceOutputAssign = [
        {
          workspace = "1";
          output = "HDMI-A-1";
        }
        {
          workspace = "2";
          output = "DP-2";
        }
        {
          workspace = "3";
          output = "DP-1";
        }
        {
          workspace = "4";
          output = "DP-3";
        }
      ];
      # startup = {
      #   set_primary = {
      #     always = true;
      #     command = "xrandr --output DP-2 --primary";
      #   };
      #   # Launch Firefox on start
      #   firefox = {
      #     command = "firefox";
      #     always = true;
      #   };
      #   keepassxc = {
      #     command = "keepassxc";
      #     always = true;
      #   };
      # };
    };
  };
}
