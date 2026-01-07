{inputs, ...}: {
  imports = [
    inputs.disko.nixosModules.disko

    ./hardware-configuration.nix

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
  ];

  hardware = {
    bluetooth.enable = false;
    enableAllFirmware = false;
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
      options = ["noauto"];
    };

    "/export/storage" = {
      device = "/storage";
      options = ["bind"];
    };

    "/export/storage/music" = {
      device = "/storage/music";
      options = ["bind"];
    };

    "/export/backup" = {
      device = "/backup";
      options = ["bind"];
    };
  };

  services.nfs.server = {
    enable = true;
    exports = ''
      /export 192.168.0.0/24(rw,fsid=0,no_subtree_check)
      /export/backup 192.168.0.0/24(rw,nohide,insecure,no_subtree_check)
      /export/storage 192.168.0.0/24(rw,nohide,insecure,no_subtree_check)
      /export/storage/music 192.168.0.0/24(rw,nohide,insecure,no_subtree_check)
    '';
    extraNfsdConfig = ''
      vers3 = off
      vers4 = true
      vers4.0 = false
      vers4.1 = false
      vers4.2 = true
    '';
  };

  networking.firewall.allowedTCPPorts = [2049];

  nixpkgs.config.allowUnfree = false;
}
