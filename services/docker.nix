{
  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
    # rootless = {
    #   enable = false;
    #   setSocketVariable = true;
    #   daemon.settings.features.cdi = true;
    daemon.settings = {
      userland-proxy = true;
      experimental = true;
      ipv6 = true;
    };
  };
}
