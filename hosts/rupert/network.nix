{
  networking = {
    hostName = "rupert";
    hostId = "0a2c4f84";
    wireless = {
      enable = false;
    };
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ];
      # allowedUDPPorts = [ ... ];
    };
  };

}
