{
  lib,
  pkgs,
  username,
  nvim,
  pkgsUnstable,
  inputs,
  ...
}: {
  imports = [
    inputs.nixcord.homeModules.nixcord

    ./mpd.nix
    ../../programs/bat.nix
    ../../programs/btop.nix
    ../../programs/cava.nix
    ../../programs/direnv.nix
    ../../programs/eza.nix
    ../../programs/firefox.nix
    ../../programs/fish.nix
    ../../programs/fzf.nix
    ../../programs/ghostty.nix
    ../../programs/git.nix
    ../../programs/go.nix
    ../../programs/gpg.nix
    ../../programs/home-manager.nix
    ../../modules/tx-02.nix
    ./discord.nix
    ./steam.nix
    ../../programs/sway.nix
    #./hyprland
    ./opencode.nix
    #./mpd.nix
    ../../programs/jq.nix
    ../../programs/keepassxc.nix
    #../../programs/kitty.nix
    #../../programs/qutebrowser.nix
    ../../programs/rmpc.nix
    ../../programs/rofi.nix
    ../../programs/sqls.nix
    ../../programs/home-ssh.nix
    ../../programs/starship.nix
    ../../programs/waybar.nix
    ../../programs/zathura.nix
    ../../programs/zed.nix
    ../../programs/zellij.nix
    ../../programs/zoxide.nix
    #../../programs/vscode.nix

    ../../services/dunst.nix
    ../../services/flameshot.nix
    #../../services/hyprpolkitagent.nix
    ../../services/gpg-agent.nix
  ];

  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "zathura";
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/about" = "firefox.desktop";
        "x-scheme-handler/unknown" = "firefox.desktop";
      };
    };
  };
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
    "org/gtk/settings/file-chooser" = {
      show-hidden = true;
      sort-directories-first = true;
    };
  };

  home = {
    file = {
      ".wallpaper" = {
        source = "${inputs.self}/wallpaper";
        recursive = true;
      };
    };
    shell = {
      enableShellIntegration = true;
    };
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "26.05"; # Please read the comment before changing.
    packages = with pkgs; [
      sops
      ssh-to-age
      age
      yt-dlp
      delta
      fastfetch
      pavucontrol
      pinentry-all
      wttrbar
      grim
      wl-clipboard
      slurp
      hyprpaper
      hyprlock
      postgresql_18
      chromium
      ffmpeg
      mutagen
      depotdownloader
      mpv
      lldb
      weechat
      playerctl
      p7zip
      lrcget
      uv
      lact
      pg_top
      libnotify
      tree-sitter
      nodejs
      gcc
      lsof
      imagemagick
      ghostscript_headless
      sqlite
      discordo
      libappindicator-gtk3
      pulseaudio-ctl
      ripgrep
      fd
      texlive.combined.scheme-full
      mermaid-cli
      sqlfluff
      xdg-utils
    ];
    sessionVariables = {
      LIBVA_DRIVER_NAME = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      EDITOR = "${nvim}/bin/nvim";
      SWAY_UNSUPPORTED_GPU = "true";
      SUDO_EDITOR = "${nvim}/bin/nvim";
      MANPAGER = "${nvim}/bin/nvim +Man!";
      MOZ_ENABLE_WAYLAND = "1";
      MOZ_USE_XINPUT2 = "1"; # smooth scroll
      NIXOS_OZONE_WL = "1";
      NVD_BACKEND = "direct";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      DEFAULT_BROWSER = "${pkgsUnstable.firefox}/bin/firefox";
    };
    sessionPath = [
      "$HOME/.nix-profile/bin"
      "/nix/var/nix/profiles/default/bin"
      "$HOME/.sm-pkg/sdks/current/addons/sourcemod/scripting"
    ];
  };
  programs.gh = {
    enable = true;
    settings = {
      aliases = {};
      editor = "nvim";
      git_protocol = "ssh";
      version = 1;
    };
  };
  programs.kitty = {
    enable = false;
    settings = {
      background_opacity = lib.mkForce "0.95";
      dynamic_background_opacity = lib.mkForce "yes";
    };
  };
  programs.obs-studio = {
    enable = true;
    package = pkgsUnstable.obs-studio;
    plugins = with pkgsUnstable.obs-studio-plugins; [
      obs-pipewire-audio-capture
      obs-tuna
      obs-vkcapture
      wlrobs
    ];
  };
  stylix.targets = {
    ghostty.enable = false;
    kitty = {
      enable = true;
    };
    hyprpaper = {
      enable = false;
    };
    # qt = {
    #   colors.enable = false;
    # };
    zellij = {
      enable = true;
      colors.enable = true;
    };
    firefox = {
      enable = true;
      colorTheme.enable = true;
      colors = {
        enable = true;
      };
    };
  };
}
