{
  stylix.targets.waybar = {
    enable = true;
    addCss = false;
    enableLeftBackColors = true;
    enableCenterBackColors = true;
    enableRightBackColors = true;
  };
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        output = "DP-3";
        #  "layer" = "Optional", // Waybar at top layer
        position = "bottom";
        height = 32; # Waybar height (to be removed for auto height)
        #width = 1280; # Waybar width
        spacing = 2; # Gaps between modules (4px)
        # Choose the order of the modules
        modules-left = [ "mpd" ];
        #modules-center = [ "clock" ];
        modules-right = [
          "systemd-failed-units"
          "custom/weather"
          "cpu"
          "memory"
          "disk#root"
          "disk#storage"
          "disk#music"
          "temperature#cpu"
          "custom/gpu-usage"
          "pulseaudio"
          "clock"
          "tray"
        ];
        systemd-failed-units = {
          "hide-on-ok" = false; # // Do not hide if there is zero failed units.
          "format" = "<span color=\"#f38ba8\">✗ {nr_failed}</span>";
          "format-ok" = "<span color=\"#a6e3a1\">✓</span>";
          "system" = true; # // Monitor failed systemwide units.
          "user" = true; # // Ignore failed user units.
        };
        "custom/weather" = {
          "format" = "{}°";
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
          format = "<span color=\"#b4befe\">{artist}</span> <span color=\"#89b4fa\">{album}</span> <span color=\"#89dceb\">{title}</span> <span color=\"#eba0ac\">{elapsedTime:%M:%S}</span>/<span color=\"#f38ba8\">{totalTime:%M:%S}</span>";
          format-disconnected = "Disconnected";
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
            off = "<span color=\"#f53c3c\"></span> ";
            on = " ";
          };
          repeat-icons = {
            on = " ";
          };
          single-icons = {
            on = "1 ";
          };
          state-icons = {
            paused = "<span color=\"#1e66f5\">></span>";
            playing = "<span color=\"#40a02b\"></span>";
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
          "format" = "󰃭 {:%Y-%m-%d <span color=\"#f9e2af\">󰥔 %H:%M</span>}";
          "format-alt" = "{:%A, %B %d, %Y (%R)}  ";
          "tooltip-format" = "<tt><small>{calendar}</small></tt>";
          "calendar" = {
            "mode" = "year";
            "mode-mon-col" = 3;
            "weeks-pos" = "right";
            "on-scroll" = 1;
            "format" = {
              "months" = "<span color='#f9e2af'><b>{}</b></span>";
              "days" = "<span color='#74c7ec'><b>{}</b></span>";
              "weeks" = "<span color='#cba6f7'><b>W{}</b></span>";
              "weekdays" = "<span color='#f5c2e7'><b>{}</b></span>";
              "today" = "<span color='#a6e3a1'><b><u>{}</u></b></span>";
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
            " <span color='#94e2d5'>{load}/{usage}%</span> {icon0}{icon1}{icon2}{icon3}{icon4}{icon5}{icon6}{icon7}";
          "format-icons" = [
            "<span color='#74c7ec'>▁</span>"
            "<span color='#89dceb'>▂</span>"
            "<span color='#94e2d5'>▃</span>"
            "<span color='#a6e3a1'>▄</span>"
            "<span color='#f9e2af'>▅</span>"
            "<span color='#fab387'>▆</span>"
            "<span color='#eba0ac'>▇</span>"
            "<span color='#f38ba8'>█</span>"
          ];
        };
        memory = {
          "states" = {
            "good" = 10;
            "warning" = 80;
            "critical" = 95;
          };
          "format" = " {percentage}%";
        };
        "temperature#cpu" = {
          # "thermal-zone": 2;
          "hwmon-path" = "/sys/class/hwmon/hwmon6/temp1_input";
          "critical-threshold" = 80;
          "format-critical" = "{icon} {temperatureC}°C";
          "format" = "{icon} {temperatureC}°C";
          "format-icons" = [
            ""
            ""
            ""
          ];
        };
        "custom/gpu-usage" = {
          # "exec"= "nvidia-smi --query-gpu=utilization.gpu,temperature.gpu,memory.used,memory.total --format=csv,noheader,nounits";
          "exec" = "nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits";
          "format" = "󰈐 {}%";
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
          "format" = "{icon} {volume}%";
          "format-muted" = "󰝟 {format_source}";
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
    # style = ''
    #   @define-color flamingo #f2cdcd;
    #   @define-color pink #f5c2e7;
    #   @define-color mauve #cba6f7;
    #   @define-color red #f38ba8;
    #   @define-color maroon #eba0ac;
    #   @define-color peach #fab387;
    #   @define-color yellow #f9e2af;
    #   @define-color green #a6e3a1;
    #   @define-color teal #94e2d5;
    #   @define-color sky #89dceb;
    #   @define-color sapphire #74c7ec;
    #   @define-color blue #89b4fa;
    #   @define-color lavender #b4befe;
    #   @define-color text #cdd6f4;
    #   @define-color subtext1 #bac2de;
    #   @define-color subtext0 #a6adc8;
    #   @define-color overlay2 #9399b2;
    #   @define-color overlay1 #7f849c;
    #   @define-color overlay0 #6c7086;
    #   @define-color surface2 #585b70;
    #   @define-color surface1 #45475a;
    #   @define-color surface0 #313244;
    #   @define-color base #1e1e2e;
    #   @define-color mantle #181825;
    #   @define-color crust #11111b;

    #   * {
    #     font-family: JetBrainsMono Nerd Font;
    #     font-size: 16px;
    #     min-height: 0;
    #   }

    #   #waybar {
    #     /*background: transparent;*/
    #     background-color: @mantle;
    #     color: @sapphire;
    #     border-bottom: 1px solid @sapphire;
    #   }

    #   #workspaces {
    #     border-radius: 1rem;
    #     margin: 5px;
    #     margin-left: 1rem;
    #   }

    #   #workspaces button {
    #     color: @lavender;
    #     border-radius: 1rem;
    #     padding: 0.4rem;
    #   }

    #   #workspaces button.active {
    #     color: @sky;
    #     border-radius: 1rem;
    #   }

    #   #workspaces button:hover {
    #     color: @sapphire;
    #     border-radius: 1rem;
    #   }

    #   #custom-music,
    #   #tray,
    #   #backlight,
    #   #clock,
    #   #battery,
    #   #mpd,
    #   #load,
    #   #network,
    #   #temperature,
    #   #memory,
    #   #cpu,
    #   #gamemode,
    #   #disk,
    #   #pulseaudio,
    #   #systemd-failed-units,
    #   #custom-lock,
    #   #custom-power {
    #     background-color: @mantle;
    #     padding: 2px 8px;
    #     margin: 0;
    #   }

    #   #systemd-failed-units {
    #     border-bottom: 1px solid @pink;
    #   }

    #   #custom-gpu-usage {
    #     color: @green;
    #     border-bottom: 1px solid @green;
    #   }

    #   #mpd {
    #     border-bottom: 1px solid @mauve;
    #   }

    #   #custom-weather {
    #     color: @yellow;
    #     border-bottom: 1px solid @yellow;
    #   }

    #   #temperature.cpu,
    #   #temperature.gpu {
    #     color: @red;
    #     border-bottom: 1px solid @red;
    #   }

    #   #disk {
    #     color: @teal;
    #     border-bottom: 1px solid @teal;
    #   }
    #   #cpu {
    #     color: @maroon;
    #     border-bottom: 1px solid @maroon;
    #   }
    #   #memory.good {
    #     color: @green;
    #     border-bottom: 1px solid @green;
    #   }

    #   #memory.warning {
    #     color: @peach;
    #     border-bottom: 1px solid @peach;
    #   }

    #   #memory.critical {
    #     color: @red;
    #     border-bottom: 1px solid @red;
    #   }

    #   #clock {
    #     color: @pink;
    #     border-bottom: 1px solid @pink;
    #   }

    #   #pulseaudio {
    #     color: @mauve;
    #     border-bottom: 1px solid @mauve;
    #   }

    #   #custom-lock {
    #     border-radius: 1rem 0px 0px 1rem;
    #   }

    #   #tray {
    #     /**margin-right: 1rem;
    #     border-radius: 1rem;*/
    #     border-bottom: 1px solid @sapphire;
    #   }
    # '';
  };
}
