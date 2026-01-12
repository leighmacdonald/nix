{
  pkgs,
  lib,
  config,
  ...
}:
{
  nixpkgs.hostPlatform = lib.mkForce "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
    initrd = {
      kernelModules = [ ];
      availableKernelModules = [
        "vmd"
        "xhci_pci"
        "ahci"
        "nvme"
        "usbhid"
        "usb_storage"
        "sd_mod"
        "uas"
        "sdhci_pci"
        "xhci_pci"
        "usbhid"
        "nvme"
        "usb_storage"
        "kvm-intel"
        "coretemp"
      ];
    };
    binfmt.emulatedSystems = [
      "aarch64-linux"
      "armv7l-linux"
    ];
    loader = {
      systemd-boot = {
        enable = true;
        #  configurationLimit = 5;
        memtest86 = {
          enable = true;
        };
        netbootxyz = {
          enable = true;
        };
        edk2-uefi-shell = {
          enable = true;
        };
      };
      efi = {
        efiSysMountPoint = "/boot/efi";
        canTouchEfiVariables = true;
      };
    };
    kernelParams = [
      "module_blacklist=i915"
    ];
  };
}
