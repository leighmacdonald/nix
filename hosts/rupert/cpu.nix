{pkgs, ...}: {
  hardware = {
    cpu = {
      intel = {
        updateMicrocode = true;
        sgx.provision.enable = true;
      };
      x86.msr.enable = true;
    };
    # https://wiki.nixos.org/wiki/Intel_Graphics
    graphics = {
      enable = true;
      extraPackages = with pkgs; [intel-media-driver intel-media-sdk intel-compute-runtime-legacy1];
    };
  };
}
