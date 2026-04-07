{ ... }:
{
  nixpkgs = {
    config.allowUnfree = true;
    config.cudaSupport = true;
    #config.cudaCapabilities = [ "8.9" ];
    config.cudaForwardCompat = true;
  };
}
