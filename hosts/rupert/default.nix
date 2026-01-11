{ pkgs, ... }:
{
  imports = [

    ./hardware-configuration.nix

    ./postgres.nix
    ./jellyfin.nix
    ./jellyseer.nix
    ./lidarr.nix
    ./prowlarr.nix
    ./qbittorrent.nix
    ./radarr.nix
    ./sonarr.nix

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

  sops.secrets = {
    prowlarr_env = {
      mode = "666";
    };
    sonarr_env = {
      mode = "666";
    };
    radarr_env = {
      mode = "666";
    };
    lidarr_env = {
      mode = "666";
    };
  };

  fileSystems = {
    "/storage" = {
      device = "media";
      fsType = "zfs";
    };

    "/storage/music" = {
      device = "music";
      fsType = "zfs";
      depends = [
        "/storage"
      ];
    };

    "/external" = {
      device = "/dev/disk/by-id/usb-Seagate_Expansion_NA8KVQ9C-0:0-part1";
      fsType = "ext4";
      options = [ "noauto" ];
    };

    "/export/storage" = {
      device = "/storage";
      options = [ "bind" ];
      depends = [
        "/storage/music"
      ];
    };

    "/export/storage/music" = {
      device = "/storage/music";
      options = [ "bind" ];
      depends = [
        "/export/storage"
      ];
    };

    "/export/backup" = {
      device = "/backup";
      options = [ "bind" ];
      depends = [
        "/backup"
      ];
    };
  };

  services.nfs = {
    settings = {
      nfsd = {
        "vers3" = false;
        "vers4" = true;
        "vers4.0" = false;
        "vers4.1" = false;
        "vers4.2" = true;
      };
    };
    server = {
      enable = true;
      exports = ''
        /export 192.168.0.0/24(rw,fsid=0,no_subtree_check)
        /export/backup 192.168.0.0/24(rw,nohide,insecure,no_subtree_check)
        /export/storage 192.168.0.0/24(rw,nohide,insecure,no_subtree_check)
        /export/storage/music 192.168.0.0/24(rw,nohide,insecure,no_subtree_check)
      '';

    };
  };

  networking.firewall.allowedTCPPorts = [ 2049 ];

  nixpkgs.config.allowUnfree = false;

  nix.settings.post-build-hook = null;
}
