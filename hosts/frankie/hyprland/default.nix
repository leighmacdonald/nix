{
  pkgs,
  ...
}:
{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || ${pkgs.hyprlock}/bin/hyprlock"; # Avoid multiple instances
      };

      listener = [
        {
          timeout = 360;
          on-timeout = "${pkgs.systemd}/bin/loginctl lock-session";
        }
        {
          timeout = 300;
          on-timeout = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
          on-resume = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
        }
      ];
    };
  };
  services.hyprpaper = {
    enable = false;
    settings = {
      preload = { };
      wallpaper = [
        {
          monitor = "DP-2";
          path = "~/.wallpaper/wp8280844-nasa-4k-wallpapers.jpg";
        }
        {
          monitor = "DP-3";
          path = "~/.wallpaper/RosetteNebula-1080.png";
        }
        {
          monitor = "HDMI-A-1";
          path = "~/.wallpaper/pillars-vertical-4k.jpg";
        }
        {
          monitor = "DP-1";
          path = "~/.wallpaper/pillars-vertical-4k.jpg";
        }
      ];
    };
  };
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
