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
        useDHCP = false;
      };
      br0 = {
        useDHCP = false;
        ipv4.addresses = [
          {
            "address" = "192.168.0.200";
            "prefixLength" = 24;
          }
        ];
        # macAddress = "00:11:11:22:11:22";
      };
    };
    defaultGateway = "192.168.0.1";
    nameservers = [
      "8.8.8.8"
      "9.9.9.9"
    ];
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
