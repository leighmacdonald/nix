{
  hardware.cpu = {
    intel = {
      updateMicrocode = true;
      sgx.provision.enable = true;
    };
    x86.msr.enable = true;
  };
}
