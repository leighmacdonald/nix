{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    extraCompatPckages = with pkgs; [
      proton-ge-bin
    ];
    extraPackages = with pkgs; [
      gamescope
    ];
    extest.enable = true;
    gamescopeSession = {
      enable = true;
    };
    #protontricks.enable = true;
    #remotePlay.openFirewall= true;
  };
}
