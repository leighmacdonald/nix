{ pkgs, username, ... }:
{
  imports = [
    ../../fs/nfs-mounts.nix
    ../../platform/rpi4
    ../../modules/secrets.nix
    ../../modules/stylix.nix
    ../../modules/nix.nix
  ];

  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/heetch.yaml";

  networking.interfaces.end0 = {
    ipv4 = {
      #useDHCP = lib.mkForce false;
      addresses = [
        {
          address = "192.168.0.100";
          prefixLength = 24;
        }
      ];
      routes = [
        {
          address = "192.168.0.0";
          prefixLength = 24;
          via = "192.168.0.1";
        }
      ];
    };
  };

  environment = {
    systemPackages = with pkgs; [
      gcc
      wget
      libraspberrypi
      libcec
      raspberrypi-eeprom
      home-manager
      jellyfin-mpv-shim
    ];
  };

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
