{ pkgs, ... }:
let
  # hyprPluginPkgs = inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system};
  hypr-plugin-dir = pkgs.symlinkJoin {
    name = "hyprland-plugins";
    paths = [ pkgs.hyprlandPlugins.hy3 ];
  };
in
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
      aspell
      aspellDicts.en
      aspellDicts.en-computers
      aspellDicts.en-science
      nfs-utils
      unzip
      unrar
      glaze
      pkg-config
      openssl
      git
      xrandr
      vulkan-tools
      atop
      dbeaver-bin
      cudatoolkit
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
      #system76-keyboard-configurator
      #pkgsUnstable.ladybird
    ];
  };
  environment.sessionVariables = {
    HYPR_PLUGIN_DIR = "${hypr-plugin-dir}/lib";
  };
  programs = {
    thunar.enable = true;
    appimage = {
      enable = true;
      binfmt = true;
    };
    hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
      # set the flake package
      #package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      #package = pkgsUnstable.hyprland;
      # make sure to also set the portal package, so that they are in sync
      #portalPackage = pkgsUnstable.xdg-desktop-portal-hyprland;
    };
    steam = {
      enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];

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
      waylandCompositors = {
        hyprland = {
          prettyName = "Hyprland";
          comment = "Hyprland compositor managed by UWSM";
          binPath = "/run/current-system/sw/bin/Hyprland";
        };
      };
    };
    #  fish = {
    #    enable = true;
    #  };
  };
}
