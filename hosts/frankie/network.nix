{
  networking = {
    hostName = "frankie";
    bridges = {
      br0 = {
        interfaces = [ "enp7s0" ];
      };
    };
    interfaces = {
      enp7s0 = {
        useDHCP = true;
      };
      br0 = {
        useDHCP = true;
        # macAddress = "00:11:11:22:11:22";
      };
    };
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
