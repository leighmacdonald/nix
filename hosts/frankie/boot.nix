{ pkgs, ... }:
{
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
      # systemd-boot = {
      #   enable = true;
      #   configurationLimit = 5;
      #   memtest86 = {
      #     enable = true;
      #   };
      #   netbootxyz = {
      #     enable = true;
      #   };
      #   edk2-uefi-shell = {
      #     enable = true;
      #   };
      #   #windows = {
      #   #  "Windows" = {
      #   #    title = "Windows";
      #   #    efiDeviceHandle = "FS1";
      #   #    sortKey = "b";
      #   #  };
      #   #};
      # };
      efi = {
        efiSysMountPoint = "/boot/efi";
        canTouchEfiVariables = true;
      };

      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
      };
    };
    # Enable audio devices
    kernelParams = [
      "module_blacklist=i915"
    ];
  };
}
