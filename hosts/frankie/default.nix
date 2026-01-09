{
  pkgs,
  lib,
  inputs,
  username,
  ...
}:
{
  imports = [
    #    inputs.impermanence.nixosModules.impermanence
    inputs.disko.nixosModules.disko

    ./hardware-configuration.nix
    ./boot.nix
    ./audio.nix
    ./network.nix
    ./cpu.nix
    ./programs.nix
    ./persistence.nix

    ../../nix.nix

    ../../env/locale.nix
    ../../env/console.nix
    ../../env/disable_services.nix

    ../../users/leigh.nix

    #../../fs/nfs.nix
    ../../modules/documentation.nix
    ../../modules/fonts.nix
    ../../modules/nvidia.nix
    ../../modules/stylix.nix
    ../../modules/secrets.nix
    ../../modules/zram.nix

    #../../programs/ssh.nix

    ../../services/docker.nix
    ../../services/node_exporter.nix
    ../../services/openssh.nix
    ../../services/tailscale.nix
  ];

  hardware = {
    bluetooth.enable = false;
    enableAllFirmware = true;
    nvidia-container-toolkit.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  services.getty = {
    autologinUser = username;
    autologinOnce = true;
  };

  systemd.services."mnt-storage.automount" = {
    wantedBy = lib.mkForce [ ];
    stopIfChanged = lib.mkForce true;
  };
  systemd.services."mnt-storage-music.automount" = {
    wantedBy = lib.mkForce [ ];
    stopIfChanged = lib.mkForce true;
  };
  systemd.services."mnt-backup.automount" = {
    wantedBy = lib.mkForce [ ];
    stopIfChanged = lib.mkForce true;
  };

  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      # make sure to also set the portal package, so that they are in sync
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
    steam = {
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
    fish = {
      enable = true;
      useBabelfish = true;
    };
    uwsm = {
      enable = true;
    };
  };
}
