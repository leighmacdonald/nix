{
  boot = {
    supportedFilesystems = [ "zfs" ];
    zfs = {
      forceImportRoot = false;
      #enabled = lib.mkForce true;
    };
    #kernelPackages = pkgs.linuxPackages_;
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
