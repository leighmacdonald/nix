{
  pkgs,
  config,
  username,
  ...
}:

{
  imports = [
    ../../nix.nix

    ./hardware-configuration.nix
    ./boot.nix
    ./audio.nix
    ./network.nix
    ./cpu.nix

    ../../fs/cifs.nix

    ../../programs/uwsm.nix
    ../../modules/documentation.nix
    ../../modules/fonts.nix
    ../../modules/nvidia.nix
    ../../modules/stylix.nix
    ../../modules/secrets.nix

    ../../services/docker.nix
    ../../services/openssh.nix
    ../../services/tailscale.nix
  ];

  hardware.enableAllFirmware = true;
  #hardware.sensor.hddtemp.enable = true;
  nixpkgs.config.allowUnfree = true;

  security = {
    sudo.wheelNeedsPassword = false;
    rtkit.enable = true;
  };

  time.timeZone = "America/Edmonton";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    enable = true;
    font = "Lat2-Terminus16";
    #keyMap = "us";
    useXkbConfig = true;
  };

  # Enable the X11 windowing system.
  services = {
    printing.enable = false;
    libinput.enable = false;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    mutableUsers = false;
    groups = {
      lusers.gid = 2000;
    };
    users."${username}" = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "docker"
      ];
      hashedPasswordFile = config.sops.secrets.password.path;
      uid = 2000;
      name = username;
      group = "lusers";
      createHome = true;
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAyvIW5JmPEviReir7aTLGDlXPX2yaI/P3/2244OC/vdEglpmsMbrXQqxkBXUd7Oh1/4f6xF0BvKGUWuqVg5ctuf9S7DZRBBYrXz66zYKiSi6uhuVdBfOCB8+4AVGCVspeapzZ0JB0H6yy/LVrmG69Z7PZKerPw+9KLAIcX4I4COrmmkbeOfShV6Nu+MeP6P6wWXzj2UcI4qcCoHJMR9iX3o63ml1PRI/CO5ZuDnTrOY/iEcg4+pvJaqBSKo3UejzikwQ35gEKOy7WHQFj1YfTbFa7Lp91Ee+6SVhJag5zLyGqNiK/vhLjGCQ4yb+0140wtUiwOZT5ELhsycA3cICmsw=="
      ];
    };
  };

  environment = {
    pathsToLink = [
      "/share/applications"
      "/share/xdg-desktop-portal"
    ];
    systemPackages = with pkgs; [
      killall
      neovim
      wget
      home-manager
      cifs-utils
    ];
  };

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
    # hyprland = {
    #   enable = true;
    #   withUWSM = true;
    #   xwayland.enable = false;
    #   #portalPackage = pkgs.xdg-desktop-portal-hyprland;
    #   portalPackage =
    #     inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    #   package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # };
    appimage = {
      enable = true;
      binfmt = true;
    };
    fish = {
      enable = true;
    };
  };

  system = {
    stateVersion = "26.05";
    copySystemConfiguration = false;
  };
}
