{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./autobrr.nix
    ./disk-config.nix
    ./bazarr.nix
    ./postgres.nix
    ./jellyfin.nix
    ./jellyseer.nix
    ./lidarr.nix
    ./prowlarr.nix
    ./qbittorrent.nix
    ./radarr.nix
    ./sonarr.nix
    ./secrets.nix

    ../../env/locale.nix
    ../../env/console.nix
    ../../env/disable_services.nix

    ../../users/root.nix
    ../../users/leigh.nix

    ../../modules/documentation.nix
    ../../modules/secrets.nix
    ../../modules/nix.nix

    ../../services/docker.nix
    ../../services/node_exporter.nix
    ../../services/openssh.nix
    ../../services/tailscale.nix
    ../../services/binary-cache.nix
    ../../services/mpd.nix
    ../../services/fstrim.nix
    ../../services/fwupd.nix
  ];
  fileSystems = {
    "/storage/music" = {
      device = "music";
      fsType = "zfs";
    };
    "/storage" = {
      device = "media";
      fsType = "zfs";
    };

    "/export/storage" = {
      device = "/storage";
      fsType = "none";
      options = [ "bind" ];
    };

    # "/export/storage/music" = {
    #   device = "/storage/music";
    #   options = [ "bind" ];
    # };

    "/export/backup" = {
      device = "/backup";
      fsType = "none";
      options = [ "bind" ];
    };
    "/external" = {
      device = "/dev/disk/by-id/usb-Seagate_Expansion_NA8KVQ9C-0:0-part1";
      fsType = "ext4";
      options = [ "noauto" ];
    };
  };

  services = {
    rpcbind = {
      enable = true;
    };
    nfs = {
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
  };

  boot = {
    supportedFilesystems = [ "zfs" ];
    zfs = {
      forceImportRoot = false;
      extraPools = [
        "media"
        "music"
      ];
    };
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
    #kernelPackages = pkgs.linuxPackages_;
    initrd = {
      availableKernelModules = [
        "uas"
        "sdhci_pci"
        "xhci_pci"
        "usbhid"
        "nvme"
        "usb_storage"
        "kvm-intel"
        "coretemp"
        "ahci"
        "sd_mod"
      ];
      kernelModules = [ ];
    };
    loader = {
      systemd-boot = {
        enable = true;
        sortKey = "a";
        configurationLimit = 5;
        memtest86 = {
          sortKey = "c";
          enable = true;
        };
        netbootxyz = {
          sortKey = "d";
          enable = true;
        };
        edk2-uefi-shell = {
          sortKey = "e";
          enable = true;
        };
      };
      efi.canTouchEfiVariables = true;
      grub.enable = false;
    };
  };
  hardware = {
    cpu = {
      intel = {
        updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
        sgx.provision.enable = true;
      };
      x86.msr.enable = true;
    };
    # https://wiki.nixos.org/wiki/Intel_Graphics
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-media-sdk
        intel-compute-runtime-legacy1
      ];
    };
  };
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-hard.yaml";
  };

  hardware = {
    bluetooth.enable = false;
    enableAllFirmware = false;
  };
  networking = {
    hostName = "rupert";
    hostId = "0a2c4f84";
    wireless.enable = false;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        2049
        6006
        5050
        6600
        8337
      ];
      allowedUDPPorts = [ 27715 ];
    };
  };

  nixpkgs = {
    hostPlatform = lib.mkForce "x86_64-linux";
    config = {
      allowUnfree = false;
      permittedInsecurePackages = [
        "python3.13-beets-2.5.1"
        "intel-media-sdk-23.2.2"
      ];
    };
  };

  nix.settings.post-build-hook = null;

  documentation.enable = false;
}
