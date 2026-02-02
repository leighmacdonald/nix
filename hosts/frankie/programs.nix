{ pkgs, inputs, ... }:
{

  environment = {
    pathsToLink = [
      "/share/applications"
      "/share/xdg-desktop-portal"
    ];
    systemPackages = with pkgs; [
      killall
      wget
      home-manager
      cifs-utils
      playerctl
      aspell
      aspellDicts.en
      aspellDicts.en-computers
      aspellDicts.en-science
      nfs-utils
      p7zip
      jellyfin-tui
      wttrbar
      unzip
      unrar
      glaze
      pkg-config
      openssl
      git
      weechat
      xrandr
    ];
  };
  programs = {
    thunar.enable = true;
    appimage = {
      enable = true;
      binfmt = true;
    };
    hyprland = {
      enable = true;
      # set the flake package
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      # make sure to also set the portal package, so that they are in sync
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
    steam = {
      enable = true;
      # extraCompatPckages = with pkgs; [
      #   proton-ge-bin
      # ];
      extraPackages = with pkgs; [
        gamescope
      ];
      extest.enable = true;
      gamescopeSession = {
        enable = true;
      };
      protontricks.enable = true;
      #remotePlay.openFirewall= true;
    };
    uwsm = {
      enable = true;
    };
    #  fish = {
    #    enable = true;
    #  };
  };
}
