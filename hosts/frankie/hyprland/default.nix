{
  pkgs,
  ...
}:
{
  wayland = {
    windowManager.hyprland = {
      enable = false;
      configType = "lua";
      systemd = {
        enable = true; # conflicts with UWSM.
        #variables = [ "--all" ];
      };
      # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
      plugins = [ pkgs.hyprlandPlugins.hy3 ];
    };
  };
}
