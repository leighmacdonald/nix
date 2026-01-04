{ pkgs, username, ... }:
{
  services = {
    displayManager = {
      defaultSession = "hyprland-uwsm";
      sddm.enable = true;
      sddm.wayland.enable = true;
      autoLogin.enable = true;
      autoLogin.user = username;
    };
  };
  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = false;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };
  };
}
