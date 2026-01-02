{
  boot = {
    # Enable audio devices
    kernelParams = [
      "snd_bcm2835.enable_hdmi=1"
      "snd_bcm2835.enable_headphones=1"
    ];
  };

  services = {
    # xserver = {
    #   xkb.layout = "us";
    # };
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };
}
