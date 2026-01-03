{
  pkgs,
  hyprland,
  username,
  ...
}:

{
  imports = [
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
    ../../programs/hyprland.nix
    ../../programs/jq.nix
    ../../programs/keepassxc.nix
    ../../programs/manpages.nix
    ../../programs/neovim
    ../../programs/nixcord.nix
    ../../programs/rmpc.nix
    ../../programs/rofi.nix
    ../../programs/sqls.nix
    ../../programs/starship.nix
    ../../programs/waybar.nix
    ../../programs/zathura.nix
    ../../programs/zed.nix
    ../../programs/zellij.nix
    ../../programs/zoxide.nix

    ../../services/dunst.nix
    ../../services/flameshot.nix
    ../../services/hyprpolkitagent.nix
    ../../services/mpd.nix
    ../../services/gpg-agent.nix
  ];
  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.11"; # Please read the comment before changing.
    packages = with pkgs; [
      nixpkgs-fmt
      nixfmt
      nixd
      statix
      alejandra
      deadnix
      package-version-server
      yaml-language-server
      superhtml
      jsonfmt
      csharp-ls
      prettier
      lua-language-server
      markdownlint-cli2
      prettierd
      rustfmt

      sqlc
      babelfish
      gci
      gofumpt
      gopls
      goreleaser
      govulncheck
      nilaway
      oapi-codegen
      templ
      vhs
      sops
      age
      nil
      click
      yt-dlp
      eslint_d
      delta
      bat
      fastfetch
      pavucontrol
      pamixer
      #      steam
      pinentry-all
      typescript-language-server
      grim
      wl-clipboard
      flameshot
      slurp
      hyprland
    ];
    sessionVariables = {
      EDITOR = "nvim";
      SUDO_EDITOR = "nvim";
      MANPAGER = "nvim +Man!";
      MOZ_USE_XINPUT2 = "1"; # smooth scroll
      NIXOS_OZONE_WL = "1";
    };
    sessionPath = [
      "$HOME/.nix-profile/bin"
      "/nix/var/nix/profiles/default/bin"
    ];
  };
}
