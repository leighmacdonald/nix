{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./disk-config.nix
    ./bazarr.nix
    ./cloudflared.nix
    #./postgres.nix
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
    ../../services/mpd.nix
    ../../services/fstrim.nix
    ../../services/fwupd.nix
    ../../services/avahi.nix
  ];
  fileSystems = {
    "/storage" = {
      device = "storage";
      fsType = "zfs";
    };

    "/storage/tv" = {
      device = "/dev/disk/by-uuid/1b23fd51-f6bf-42ae-982f-a21a333ce3f2";
      fsType = "ext4";
      depends = [ "/storage" ];
    };

    "/storage/movies" = {
      device = "/dev/disk/by-uuid/7f141dcd-fb90-4ba4-8774-46c06c88fc3d";
      fsType = "ext4";
      depends = [ "/storage" ];
    };

    # "/storage/downloads" = {
    #   device = "/storage/music/media/downloads";
    #   fsType = "none";
    #   options = [ "bind" ];
    # };

    "/export/storage" = {
      device = "/storage";
      fsType = "none";
      options = [ "bind" ];
      depends = [ "/storage" ];
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
      enable = false;
    };
    nfs = {
      server = {
        enable = true;
        exports = ''
          /export 192.168.0.0/24(rw,fsid=0,no_subtree_check)
          /export/backup 192.168.0.0/24(rw,nohide,insecure,no_subtree_check)
          /export/storage 192.168.0.0/24(rw,nohide,insecure,no_subtree_check)
          /export/storage/tv 192.168.0.0/24(rw,nohide,insecure,no_subtree_check)
          /export/storage/movies 192.168.0.0/24(rw,nohide,insecure,no_subtree_check)
        '';
      };
    };
  };

  # Hard-bind services to the mount units for the paths they use, so the
  # ZFS pool (/storage) and its child mounts (tv/movies ext4, /export bind
  # mounts) are mounted before these services start. If a mount fails,
  # the dependent services stay down rather than running against bare
  # mountpoint directories.
  systemd.services =
    let
      storageDeps = {
        jellyfin = [ "storage.mount" ];
        qbittorrent = [ "storage.mount" ];
        mpd = [ "storage.mount" ];
        mpdscribble = [ "storage.mount" ];
        seerr = [ "storage.mount" ];
        lidarr = [ "storage.mount" ];
        prowlarr = [ "storage.mount" ];
        sonarr = [
          "storage.mount"
          "storage-tv.mount"
        ];
        radarr = [
          "storage.mount"
          "storage-movies.mount"
        ];
        bazarr = [
          "storage.mount"
          "storage-tv.mount"
          "storage-movies.mount"
        ];
        nfs-server = [
          "storage.mount"
          "export-storage.mount"
          "export-backup.mount"
        ];
        nfs-mountd = [
          "storage.mount"
          "export-storage.mount"
          "export-backup.mount"
        ];
      };
    in
    lib.mapAttrs (_: mounts: {
      after = mounts;
      requires = mounts;
    }) storageDeps;

  boot = {
    supportedFilesystems = [ "zfs" ];
    zfs = {
      forceImportRoot = false;
      extraPools = [
        "storage"
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
    enableIPv6 = true;
    wireless.enable = false;
    # The ISP router does not offer SLAAC (RA has autonomous=off) and its
    # DHCPv6 server answers "No addresses available for this interface",
    # so the global address is pinned statically in the on-link /64 that
    # the router advertises. Update the prefix here if the ISP renumbers.
    interfaces.eno1.ipv6.addresses = [
      {
        address = "2001:56a:7426:6d00::201";
        prefixLength = 64;
      }
    ];
    # Static IPv6 would otherwise make dhcpcd disable Router Advertisements
    # for eno1, and with them the IPv6 default route. Keep RS enabled; dhcpcd
    # installs the default route from the router's RA.
    dhcpcd.IPv6rs = true;
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
