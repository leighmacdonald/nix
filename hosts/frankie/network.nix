{
  networking = {
    hostName = "frankie";
    wireless = {
      enable = false;
    };
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        5432
        5445
        6006
        6007
      ];
      allowedUDPPorts = [
        6006
        6007
        27715
      ];
    };
  };
}
