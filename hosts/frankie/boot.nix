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
    ];
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
      };
    };
    # Enable audio devices
    kernelParams = [
      "module_blacklist=i915"
    ];
  };
}
