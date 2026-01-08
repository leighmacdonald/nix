{
  config,
  pkgs,
  username,
  hostName,
  ...
}:
{
  imports = [
    ../../accounts/email.nix
  ];
  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  xdg = {
    autostart.enable = true;
    configFile."uwsm/env".source =
      "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
    portal = {
      enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
    };
  };
  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 96;
  };
  home = {
    #uid = 2000;
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.11";

    #packages = with pkgs; [ ];
  };
  wayland.windowManager.hyprland = {
    systemd.variables = [ "--all" ];
    enable = true;
    settings = {
      "$mainMod" = "CTRL";
      "$terminal" = "foot";
      "$fileManager" = "thunar";
      "$menu" = "rofi -show drun -show-icons"; # -run-command 'runapp {cmd}'";
      animations = {
        enabled = false;
      };
      bindel = [
        " ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        " ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];
      bind = [
        "$mainMod, return, exec, $terminal"
        "$mainMod, m, exec, hyprshutdown -t ahhhh --post-cmd 'uwsm stop'"
        "$mainMod, d, exec, $menu"
        "$mainMod, f, exec, firefox"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (
          builtins.genList (
            i:
            let
              ws = i + 1;
            in
            [
              "$mainMod, code:1${toString i}, workspace, ${toString ws}"
              "$mainMod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          ) 9
        )
      );
    };
  };

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      #waylandSupport = true;
    };
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
      nativeMessagingHosts = [ pkgs.keepassxc ];

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
