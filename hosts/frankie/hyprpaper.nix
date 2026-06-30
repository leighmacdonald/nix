let
  wallpaperPath = "/projects/nix/wallpaper/";
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = { };
      wallpaper = [
        {
          monitor = "DP-2";
          path = wallpaperPath + "wp8280844-nasa-4k-wallpapers.jpg";
        }
        {
          monitor = "DP-3";
          path = wallpaperPath + "RosetteNebula-1080.png";
        }
        {
          monitor = "HDMI-A-1";
          path = wallpaperPath + "pillars-vertical-4k.jpg";
        }
        {
          monitor = "DP-1";
          path = wallpaperPath + "pillars-vertical-4k.jpg";
        }
      ];
    };
  };
}
