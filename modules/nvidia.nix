{
  inputs,
  pkgs,
  nixpkgs-unstable,
  ...
}: {
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
      #package = nixpkgs-unstable.nvidia;
    };
    # nvidia-container-toolkit.enable = true;
  };

  services = {
    xserver = {
      autorun = false;
      videoDrivers = ["nvidia"];
    };
  };
}
