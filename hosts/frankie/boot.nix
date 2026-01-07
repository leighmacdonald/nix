{ pkgs, ... }:
{
  stylix.targets.grub = {
    #useWallpaper = true;
    enable = true;
  };

  hardware.keyboard.qmk.enable = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.availableKernelModules = [
      "uas"
      "sdhci_pci"
      "xhci_pci"
      "usbhid"
      "nvme"
      "usb_storage"
      "kvm-intel"
      "coretemp"
    ];
    binfmt.emulatedSystems = [
      "aarch64-linux"
      "armv7l-linux"
    ];
    loader = {
      systemd-boot = {
        enable = true;
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
      efi.canTouchEfiVariables = true;
      grub.enable = false;
    };
    # Enable audio devices
    kernelParams = [
      "module_blacklist=i915"
    ];
  };
}
