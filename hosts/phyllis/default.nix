{lib,
  pkgs,
  username,
  ...
}: {
  imports = [
    ../../fs/nfs-mounts.nix
    ../../platform/rpi4
    ../../modules/secrets.nix
    ../../modules/nix.nix
  ];

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
  programs.sway.enable = true;
  security.polkit.enable = true;
  environment = {
    systemPackages = with pkgs; [
      wget
      libraspberrypi
      libcec
      raspberrypi-eeprom
      home-manager
      vlc
      mpv
      mako
      pavucontrol
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
    pathsToLink = ["share/applications" "/share/xdg-desktop-portal"];
  };
  services = {
    displayManager = {
      defaultSession = "sway";
      sddm.enable = true;
      sddm.wayland.enable = true;
      autoLogin.enable = true;
      autoLogin.user = username;
    };
  };
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "chromium"
    "chromium-unwrapped"
    "widevine-cdm"
  ];
}
