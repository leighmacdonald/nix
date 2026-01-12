{
  hardware = {
    enableRedistributableFirmware = true;
    graphics = {
      enable = true;
      enable32Bit = true; # steam.... :(
    };
    nvidia = {
      modesetting.enable = true;
      #powerManagement.finegrained = true;
      open = true;
      #package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
    # nvidia-container-toolkit.enable = true;
  };

  services = {
    xserver = {
      autorun = false;
      videoDrivers = [ "nvidia" ];
    };
  };
}
