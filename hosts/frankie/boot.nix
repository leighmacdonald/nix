{
  pkgs,
  ...
}:
{

  boot = {
    #kernelPackages = pkgs.linuxPackages_latest;
    kernelPackages = pkgs.linuxPackages_zen;
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
    initrd = {
      kernelModules = [ ];
      availableKernelModules = [
        "aesni_intel"
        "cryptd"
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
        memtest86.enable = true;
        netbootxyz.enable = true;
        edk2-uefi-shell.enable = true;
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
