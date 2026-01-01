{
  hardware.cpu = {
    intel = {
      sgx.provision.enable = true;
      updateMicrocode = true;
    };
    x86.msr.enable = true;
  };
}
