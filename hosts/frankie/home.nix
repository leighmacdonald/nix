{
  pkgs,
  username,
  config,
  pkgsUnstable,
  ...
}:
{
  imports = [
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
    ./hyprland
    #./mpd.nix
    ../../programs/jq.nix
    ../../programs/keepassxc.nix
    ../../programs/kitty.nix
    ../../programs/neovim
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
    ../../services/hyprpolkitagent.nix
    ../../services/gpg-agent.nix
  ];

  # LSP stubs for Hyprland's Lua API at a stable user path. The hyprland
  # package's share/hypr/stubs dir changes hash on each upgrade, so we link
  # it into ~/.local/share/hypr/stubs and reference *that* from .luarc.json.
  # Updates automatically on rebuild.
  home.file.".local/share/hypr/stubs".source = "${pkgs.hyprland}/share/hypr/stubs";
  # Hyprland user config is driven by the symlinked Lua tree below
  # (lua/hyprland.lua and friends). The home-manager Hyprland module is left
  # disabled here so it doesn't write the legacy hyprland.conf — Hyprland 0.55+
  # reads hyprland.lua natively. The system-level NixOS Hyprland module still
  # handles the session/UWSM/portal bits.
  wayland.windowManager.hyprland.enable = false;
  # Live-edit symlink: edits to lua/*.lua under ~/code/nixos-config (and the
  # per-host overrides under ~/code/infra) take effect immediately via
  # Hyprland's autoreload. No nixos-rebuild needed for keybinds or rules.
  xdg.configFile."hypr/hyprland.lua".source =
    config.lib.file.mkOutOfStoreSymlink "/projects/nix/hosts/frankie/hyprland/lua/hyprland.lua";
  # UWSM env injection — sources home-manager's session vars (including
  # home.sessionPath additions like ~/.local/bin) into the Hyprland session
  # via UWSM. Without this, Hyprland-spawned processes can't find
  # home.file-installed scripts in ~/.local/bin (rofi menus, pypr-toggle-smart,
  # etc.). Per https://wiki.hypr.land/Nix/Hyprland-on-Home-Manager/#nixos-uwsm.
  xdg.configFile."uwsm/env".source =
    "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };
  #xdg.configFile."fish/config.fish".force = true;
  home = {
    shell = {
      enableShellIntegration = true;
    };
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "26.05"; # Please read the comment before changing.
    #    shellAliases = {
    #      "cd" = "zoxide";
    #    };

    #xdg.configFile."fish/config.fish".force = true;

    packages = with pkgs; [
      # babelfish
      sops
      ssh-to-age
      age

      yt-dlp
      delta
      bat
      fastfetch
      pavucontrol
      pinentry-all
      wttrbar
      grim
      wl-clipboard
      flameshot
      slurp
      hyprpaper
      hyprlock
      postgresql_18
      chromium
      ffmpeg
      mutagen
      # clang
      # Replace llvmPackages with llvmPackages_X, where X is the latest LLVM version (at the time of writing, 16)
      #llvmPackages_21.bintools
      # rustup
      # pkg-config
      # openssl
      # cargo-audit

      depotdownloader

      mpv
      lldb
      vscode-extensions.vadimcn.vscode-lldb
      weechat
      playerctl

      p7zip
      wttrbar
      discord
      lrcget
    ];
    sessionVariables = {
      LIBVA_DRIVER_NAME = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      EDITOR = "nvim";
      SUDO_EDITOR = "nvim";
      MANPAGER = "nvim +Man!";
      MOZ_ENABLE_WAYLAND = "1";
      MOZ_USE_XINPUT2 = "1"; # smooth scroll
      NIXOS_OZONE_WL = "1";
      NVD_BACKEN = "direct";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      HYPR_PLUGINS_DIR = "${
        pkgs.symlinkJoin {
          name = "hyprland-plugins";
          paths = [ "${pkgs.hyprlandPlugins.hy3}" ];
        }
      }/lib";
    };
    sessionPath = [
      "$HOME/.nix-profile/bin"
      "/nix/var/nix/profiles/default/bin"
      "$HOME/.sm-pkg/sdks/current/addons/sourcemod/scripting"
    ];
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
  stylix.targets.firefox = {
    enable = true;
    colorTheme.enable = true;
    colors = {
      enable = true;
    };
  };
}
