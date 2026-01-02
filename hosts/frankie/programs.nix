{ pkgs, ... }:
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
    ];
  };

  programs = {
    appimage = {
      enable = true;
      binfmt = true;
    };
    fish.enable = true;
  };
}
