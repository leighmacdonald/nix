{
  networking = {
    hostName = "frankie";
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
