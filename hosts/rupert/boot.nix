{
  config,
  lib,
  ...
}:
{
  nixpkgs.hostPlatform = lib.mkForce "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
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
}
