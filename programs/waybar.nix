{ config, ... }:
{
  stylix.targets.waybar = {
    enable = true;
    addCss = false;
    enableLeftBackColors = false;
    enableCenterBackColors = false;
    enableRightBackColors = false;
    fonts.enable = false;

  };
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      enableInspect = false;
    };
    settings = {
      mainBar = {
        output = "DP-3";
        #  "layer" = "Optional", // Waybar at top layer
        position = "bottom";
        #height = 32; # Waybar height (to be removed for auto height)
        #width = 1280; # Waybar width
        spacing = 12; # Gaps between modules (4px)
        # Choose the order of the modules
        modules-left = [ "mpd" ];
        # modules-center = [ "clock" ];
        modules-right = [
          "systemd-failed-units"
          "custom/weather"
          "cpu"
          "memory"
          #"disk#root"
          #"disk#storage"
          #"disk#music"
          "temperature#cpu"
          "custom/gpu-usage"
          "pulseaudio"
          "tray"
          "clock"
        ];
        systemd-failed-units = {
          "hide-on-ok" = false; # // Do not hide if there is zero failed units.
          "format" = "<span color=\"${config.lib.stylix.colors.withHashtag.base08}\">✗ {nr_failed}</span>";
          "format-ok" = "<span color=\"${config.lib.stylix.colors.withHashtag.base0B}\">✓</span>";
          "system" = true; # // Monitor failed systemwide units.
          "user" = true; # // Ignore failed user units.
        };
        "custom/weather" = {
          "format" = "<span color=\"${config.lib.stylix.colors.withHashtag.base0C}\">{}°</span>";
          "tooltip" = true;
          "interval" = 3600;
          "exec" = "wttrbar --hide-conditions --nerd";
          "return-type" = "json";
        };
        "disk#root" = {
          "interval" = 30;
          "format" = " {percentage_free}%";
          "path" = "/";
        };
        "disk#storage" = {
          "interval" = 30;
          "format" = "󰒍 {percentage_free}%";
          "path" = "/mnt/storage";
        };
        "disk#music" = {
          "interval" = 30;
          "format" = " {percentage_free}%";
          "path" = "/mnt/storage/music";
        };
        "hyprland/workspaces" = {
          "persistent-workspaces" = {
            "1" = [ "HDMI-A-1" ];
            "2" = [ "DP-2" ];
            "3" = [ "DP-1" ];
            "4" = [ "DP-3" ];
          };
        };
        gamemode = {
          "format" = "{glyph}";
          "format-alt" = "{glyph} {count}";
          "glyph" = "";
          "hide-not-running" = true;
          "use-icon" = true;
          "icon-name" = "input-gaming-symbolic";
          "icon-spacing" = 4;
          "icon-size" = 16;
          "tooltip" = true;
          "tooltip-format" = "Games running: {count}";
        };
        mpd = {
          server = "/tmp/mpd_socket";
          #  <span color=\"#eba0ac\">{elapsedTime:%M:%S}</span>/<span color=\"#f38ba8\">{totalTime:%M:%S}</span>
          format = "<span color=\"${config.lib.stylix.colors.withHashtag.base08}\">{artist}</span> <span color=\"${config.lib.stylix.colors.withHashtag.base09}\">{album}</span> <span color=\"${config.lib.stylix.colors.withHashtag.base0A}\">{title}</span>";
          format-disconnected = "<span color=\"${config.lib.stylix.colors.withHashtag.base08}\">MPD Disconnected</span>";
          format-stopped = "Stopped";
          unknown-tag = "N/A";
          interval = 2;
          on-click = "ghostty -e rmpc";
          expand = true;
          #"max-length" = 100;
          consume-icons = {
            on = " ";
          };
          random-icons = {
            off = "<span color=\"${config.lib.stylix.colors.withHashtag.base0F}\"></span> ";
            on = " ";
          };
          repeat-icons = {
            on = " ";
          };
          single-icons = {
            on = "1 ";
          };
          state-icons = {
            paused = "<span color=\"${config.lib.stylix.colors.withHashtag.base0A}\">></span>";
            playing = "<span color=\"${config.lib.stylix.colors.withHashtag.base0B}\"></span>";
          };
          tooltip-format = "MPD (connected)";
          tooltip-format-disconnected = "MPD (disconnected)";
        };
        idle_inhibitor = {
          "format" = "{icon}";
          "format-icons" = {
            "activated" = "";
            "deactivated" = "";
          };
        };
        tray = {
          "icon-size" = 24;
          "spacing" = 6;
        };
        clock = {
          "timezone" = "America/Edmonton";
          "format" = "<span color=\"${config.lib.stylix.colors.withHashtag.base0B}\">{:%H:%M}  </span>";
          "format-alt" =
            "<span color=\"${config.lib.stylix.colors.withHashtag.base0B}\">{:%A, %B %d, %Y (%R)} </span>";
          # "format" =
          #   "<span color=\"${config.lib.stylix.colors.withHashtag.base0C}\">󰃭 {:%Y-%m-%d}</span> <span color=\"${config.lib.stylix.colors.withHashtag.base0B}\">󰥔 {:%H:%M}</span>";
          # "format-alt" = "{:%A, %B %d, %Y (%R)}  ";
          "tooltip-format" = "<tt><small>{calendar}</small></tt>";
          "calendar" = {
            "mode" = "year";
            "mode-mon-col" = 3;
            "weeks-pos" = "right";
            "on-scroll" = 1;
            "format" = {
              "months" = "<span color='${config.lib.stylix.colors.withHashtag.base09}'><b>{}</b></span>";
              "days" = "<span color='${config.lib.stylix.colors.withHashtag.base0E}'><b>{}</b></span>";
              "weeks" = "<span color='${config.lib.stylix.colors.withHashtag.base0C}'><b>W{}</b></span>";
              "weekdays" = "<span color='${config.lib.stylix.colors.withHashtag.base0D}'><b>{}</b></span>";
              "today" = "<span color='${config.lib.stylix.colors.withHashtag.base0B}'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            "on-click-right" = "mode";
            "on-scroll-up" = "tz_up";
            "on-scroll-down" = "tz_down";
          };
        };
        cpu = {
          "interval" = 1;
          "format" =
            "<span color='${config.lib.stylix.colors.withHashtag.base0D}'>  {load}/{usage:3}%</span> {icon0}{icon1}{icon2}{icon3}{icon4}{icon5}{icon6}{icon7}";
          "format-icons" = [
            "<span color='${config.lib.stylix.colors.withHashtag.base0F}'>▁</span>"
            "<span color='${config.lib.stylix.colors.withHashtag.base0E}'>▂</span>"
            "<span color='${config.lib.stylix.colors.withHashtag.base0D}'>▃</span>"
            "<span color='${config.lib.stylix.colors.withHashtag.base0C}'>▄</span>"
            "<span color='${config.lib.stylix.colors.withHashtag.base0B}'>▅</span>"
            "<span color='${config.lib.stylix.colors.withHashtag.base0A}'>▆</span>"
            "<span color='${config.lib.stylix.colors.withHashtag.base09}'>▇</span>"
            "<span color='${config.lib.stylix.colors.withHashtag.base08}'>█</span>"
          ];
        };
        memory = {
          "states" = {
            "good" = 10;
            "warning" = 80;
            "critical" = 95;
          };
          "format" = "<span color=\"${config.lib.stylix.colors.withHashtag.base0F}\"> {percentage}%</span>";
        };
        "temperature#cpu" = {
          # "thermal-zone": 2;
          "hwmon-path" = "/sys/class/hwmon/hwmon6/temp1_input";
          "critical-threshold" = 80;
          "format-critical" =
            "<span color=\"${config.lib.stylix.colors.withHashtag.base08}\">{icon} {temperatureC}°C</span>";
          "format" =
            "<span color=\"${config.lib.stylix.colors.withHashtag.base0C}\">{icon} {temperatureC}°C</span>";
          "format-icons" = [
            ""
            ""
            ""
          ];
        };
        "custom/gpu-usage" = {
          # "exec"= "nvidia-smi --query-gpu=utilization.gpu,temperature.gpu,memory.used,memory.total --format=csv,noheader,nounits";
          "exec" = "nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits";
          "format" = "<span color=\"${config.lib.stylix.colors.withHashtag.base0B}\">󰈐 {:2}%</span>";
          "return-type" = "";
          "interval" = 1;
        };
        load = {
          "interval" = 1;
          "format" = "load: {load1} {load5} {load15}";
        };
        network = {
          "interface" = "tailscale0"; # // (Optional) To force the use of this interface
          "format-wifi" = "{essid} ({signalStrength}%) ";
          "format-ethernet" = "{ipaddr}/{cidr} ";
          "tooltip-format" = "{ifname} via {gwaddr} ";
          "format-linked" = "{ifname} (No IP) ";
          "format-disconnected" = "Disconnected ⚠";
          "format-alt" = "{ifname}: {ipaddr}/{cidr}";
        };
        user = {
          "format" = "up {work_d} days ↑";
          "icon" = false;
        };
        pulseaudio = {
          "format" =
            "<span color=\"${config.lib.stylix.colors.withHashtag.base0E}\">{icon} {volume:3}%</span>";
          "format-muted" =
            "<span color=\"${config.lib.stylix.colors.withHashtag.base08}\">󰝟 {format_source}</span>";
          "format-source" = "{volume}%";
          "format-source-muted" = "";
          "format-icons" = {
            "headphone" = "";
            "hands-free" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = [
              ""
              ""
              ""
            ];
          };
          "on-click" = "pavucontrol";
        };
      };
    };
  };
}
