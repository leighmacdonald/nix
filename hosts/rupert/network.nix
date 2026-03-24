{
  networking = {
    hostName = "rupert";
    hostId = "0a2c4f84";
    wireless = {
      enable = false;
    };
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        6006
        5050
        6600
      ];
      allowedUDPPorts = [ 27715 ];
    };
  };

}
