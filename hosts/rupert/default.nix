{ pkgs, ... }:
{
  imports = [
    ./disk-config.nix
    ./boot.nix
    ./network.nix
    ./cpu.nix
    ./bazarr.nix
    ./postgres.nix
    ./jellyfin.nix
    ./jellyseer.nix
    ./lidarr.nix
    ./nfs.nix
    ./prowlarr.nix
    ./qbittorrent.nix
    ./radarr.nix
    ./sonarr.nix
    ./secrets.nix

    ../../nix.nix

    ../../env/locale.nix
    ../../env/console.nix
    ../../env/disable_services.nix

    ../../users/root.nix
    ../../users/leigh.nix

    ../../modules/nodocumentation.nix
    ../../modules/secrets.nix

    ../../services/docker.nix
    ../../services/node_exporter.nix
    ../../services/openssh.nix
    ../../services/tailscale.nix
    ../../services/binary-cache.nix
  ];

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-hard.yaml";
  };

  hardware = {
    bluetooth.enable = false;
    enableAllFirmware = false;
  };

  fileSystems = {
    "/external" = {
      device = "/dev/disk/by-id/usb-Seagate_Expansion_NA8KVQ9C-0:0-part1";
      fsType = "ext4";
      options = [ "noauto" ];
    };
  };

  nixpkgs.config.allowUnfree = false;

  nix.settings.post-build-hook = null;
}
