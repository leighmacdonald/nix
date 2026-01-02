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

    ../../programs/uwsm.nix
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

  hardware.enableAllFirmware = true;
  #hardware.sensor.hddtemp.enable = true;
  nixpkgs.config.allowUnfree = true;
}
