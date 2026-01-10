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
      clang
      #aspellDicts
      nfs-utils
      p7zip
      jellyfin-tui
    ];
  };

  programs = {
    thunar.enable = true;
    appimage = {
      enable = true;
      binfmt = true;
    };
    #  fish = {
    #    enable = true;
    #  };
  };
}
