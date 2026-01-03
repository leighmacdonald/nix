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
      aspell
      aspellDicts.en
      aspellDicts.en-computers
      aspellDicts.en-science
      #aspellDicts
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
