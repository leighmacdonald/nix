{ lib, config, ... }:
{
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
