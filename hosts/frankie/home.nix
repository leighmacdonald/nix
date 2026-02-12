{
  pkgs,
  username,
  ...
}: {
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
    ./hyprland.nix
    #./mpd.nix
    ../../programs/jq.nix
    ../../programs/keepassxc.nix
    ../../programs/kitty.nix
    ../../programs/neovim
    ../../programs/nixcord.nix
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

    ../../services/dunst.nix
    ../../services/flameshot.nix
    ../../services/hyprpolkitagent.nix
    ../../services/gpg-agent.nix
  ];
  #xdg.configFile."fish/config.fish".force = true;
  home = {
    shell = {
      enableShellIntegration = true;
    };
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.11"; # Please read the comment before changing.
    # shellAliases = {
    #   "cd" = "zoxide";
    # };

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

      clang
      # Replace llvmPackages with llvmPackages_X, where X is the latest LLVM version (at the time of writing, 16)
      #llvmPackages_21.bintools
      rustup
      pkg-config
      openssl
      cargo-audit

      package-version-server
      csharp-ls
      prettier
      jsonfmt
      clang-tools
      clang-analyzer
      stylua
      lua-language-server
      markdownlint-cli2
      prettierd
      sqlc
      eslint_d
      gci
      gofumpt
      gopls
      typescript-language-server
      python3
      depotdownloader
    ];
    sessionVariables = {
      RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
      # Set env variables so we can refer to them from the vim configuration
      CODELLDB_PATH = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
      LIBLLDB_PATH = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/lldb/lib/liblldb.so";
      EDITOR = "nvim";
      SUDO_EDITOR = "nvim";
      MANPAGER = "nvim +Man!";
      MOZ_ENABLE_WAYLAND = "1";
      MOZ_USE_XINPUT2 = "1"; # smooth scroll
      NIXOS_OZONE_WL = "1";
      PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    };
    sessionPath = [
      "$HOME/.nix-profile/bin"
      "/nix/var/nix/profiles/default/bin"
      "$HOME/.sm-pkg/sdks/current/addons/sourcemod/scripting"
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
