{
  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
    # rootless = {
    #   enable = false;
    #   setSocketVariable = true;
    #   daemon.settings.features.cdi = true;
    daemon.settings = {
      userland-proxy = false;
      experimental = true;
      ipv6 = false;
    };
  };
}
