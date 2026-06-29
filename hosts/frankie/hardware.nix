{ lib, config, ... }:
{
  fileSystems = {
    "/dump" = {
      device = "/dev/disk/by-id/nvme-Samsung_SSD_980_PRO_1TB_S5P2NG0R404138D-part1";
      fsType = "ext4";
      options = [
        "noatime"
      ];
    };
  };
  hardware = {
    bluetooth.enable = false;
    cpu = {
      intel = {
        updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
        sgx.provision.enable = true;
      };
      x86.msr.enable = true;
    };
  };
}
