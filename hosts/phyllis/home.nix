{
  config,
  pkgs,
  username,
  hostName,
  ...
}: {
  imports = [
    ../../env/email.nix
  ];
  xdg = {
    autostart.enable = true;
    configFile."uwsm/env".source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
      ];
      config.common.default = "*";
    };
  };
  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 24;
    "Xft.dpi" = 96;
  };
  home = {
    uid = 2000;
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "26.05";
    packages = with pkgs; [playerctl jellyfin-desktop jellyfin-mpv-shim  (chromium.override {
       enableWideVine = true;
       commandLineArgs = [
         "--ozone-platform=wayland"
         "--use-gl=egl"
         "--enable-features=V4L2VideoDecoder,WaylandWindowDecorations"
         "--ignore-gpu-blocklist"
         "--enable-gpu-rasterization"
       ];
     })];
  };
  services.jellyfin-mpv-shim = {
    enable = true;
    settings = {
      allow_transcode_to_h265 = false;
      always_transcode = false;
      #audio_output = "hdmi";
      close_to_tray = true;
      allow_background = true;
      auto_play = true;
      fullscreen = false;
      player_name = "mpv-shim";
      direct_paths = true;
      remote_direct_paths = true;
    };
  };
  services.swayidle = {
    enable = false;
    systemdTargets = ["graphical-session.target"];
    timeouts = [
      {
        timeout = 330;
        command = "${pkgs.playerctl}/bin/playerctl pause; ${pkgs.sway}/bin/swaymsg 'output * dpms off'";
        resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * dpms on'";
      }
    ];
  };
  services.swayosd = {
    enable = true;
    topMargin = 0.9;
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
  wayland.windowManager.sway = {
    systemd = {
      enable = true;
      xdgAutostart = true;
      variables = ["--all"];
    };
    enable = true;
    checkConfig = false;
    wrapperFeatures.gtk = true; # Fixes common issues with GTK 3 apps
    config = {
      bars = []; # Disables default bar
      modifier = "Alt";
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
      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
      in
        {
          "${modifier}+Shift+e" = "exec uwsm stop";
          "${modifier}+q" = "kill";
          "${modifier}+d" = "exec rofi -show drun -show-icons";
          "${modifier}+f" = "fullscreen toggle";
          "XF86AudioRaiseVolume" = "exec swayosd-client --output-volume raise";
          "XF86AudioLowerVolume" = "exec swayosd-client --output-volume lower";
          "XF86AudioMute" = "exec swayosd-client --output-volume mute-toggle";
          "XF86AudioMicMute" = "exec swayosd-client  --input-volume mute-toggle";
          "XF86AudioPlay" = "exec swayosd-client --playerctl play-pause";
          "XF86AudioNext" = "exec swayosd-client --playerctl next";
          "XF86AudioPrev" = "exec swayosd-client --playerctl prev";
        };
      input = {
        "type:pointer" = {
          accel_profile = "flat";
          pointer_accel = "0";
        };
      };
    };
  };

  programs = {
    foot.enable = true;
    mpv.enable = true;
    rofi.enable = true;
    keepassxc = {
      enable = true;
      autostart = true;
      # https://github.com/keepassxreboot/keepassxc/blob/647272e9c5542297d3fcf6502e6173c96f12a9a0/src/core/Config.cpp#L49-L223
      settings = {
        General = {
          AutoGeneratePasswordForNewEntries = true;
          ConfigVersion = 2;
          MinimizeAfterUnlock = true;
        };

        Browser = {
          Enabled = true;
          UpdateBinaryPath = false;
        };
        GUI = {
          ApplicationTheme = "dark";
          CompactMode = true;
          MinimizeOnClose = true;
          MinimizeToTray = true;
          ShowTrayIcon = true;
          TrayIconAppearance = "monochrome-dark";
        };

        PasswordGenerator = {
          Length = 20;
        };

        Security = {
          ClearClipboard = false;
          IconDownloadFallback = true;
          LockDatabaseIdle = false;
        };

        FdoSecrets = {
          Enabled = true;
        };
      };
    };
    #chromium.enable = true;
    firefox = {
      enable = true;
      nativeMessagingHosts = [pkgs.keepassxc];
      configPath = ".mozilla/firefox";
      profiles = {
        bedroom = {
          isDefault = true;
          name = hostName;
          settings = {
            "webgl.disabled" = false;
            "privacy.resistFingerprinting" = false;
            "privacy.clearOnShutdown.history" = false;
            "privacy.clearOnShutdown.cookies" = false;
            "network.cookie.lifetimePolicy" = 0;
            "browser.cache.disk.enable" = false;
            "browser.cache.memory.capacity" = -1;
            "browser.cache.memory.enable" = true;
          };
          # extensions = {

          # };
        };
      };

      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        ExtensionSettings = {
          "jid1-ZAdIEUB7XOzOJw@jetpack" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/duckduckgo-for-firefox/latest.xpi";
            installation_mode = "force_installed";
          };
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };
        };
      };
    };
    git = {
      enable = true;
      settings.user = {
        name = config.accounts.email.accounts.default.realName;
        email = config.accounts.email.accounts.default.address;
      };
    };
    home-manager.enable = true;
  };
}
