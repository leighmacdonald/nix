{ pkgs, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./audio.nix
    ./network.nix
    ./cpu.nix
    ./programs.nix

    ../../nix.nix

    ../../env/locale.nix
    ../../env/console.nix
    ../../env/disable_services.nix

    ../../users/leigh.nix

    ../../fs/cifs.nix

    ../../modules/documentation.nix
    ../../modules/fonts.nix
    ../../modules/nvidia.nix
    ../../modules/stylix.nix
    ../../modules/secrets.nix
    ../../modules/zram.nix

    ../../services/docker.nix
    ../../services/openssh.nix
    ../../services/tailscale.nix
  ];

  hardware.bluetooth.enable = false;
  hardware.enableAllFirmware = true;

  #hardware.sensor.hddtemp.enable = true;
  nixpkgs.config.allowUnfree = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
  programs.steam = {
    enable = true;
    # extraCompatPckages = with pkgs; [
    #   proton-ge-bin
    # ];
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

  programs.uwsm = {
    enable = true;

    waylandCompositors = {
      #   hyprland-hm = {
      #     prettyName = "Hyprland";
      #     comment = "Hyprland managed by UWSM";
      #     binPath = "/etc/profiles/per-user/leigh/bin/hyprland";
      #   };
    };
  };
}
