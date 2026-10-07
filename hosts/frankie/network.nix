{
  # Explicitly keep IPv6 enabled (default true, but guards against any
  # module disabling it) and accept Router Advertisements on br0 even
  # though IPv6 forwarding is enabled (required for the bridge/VMs).
  # accept_ra=1 ignores RAs when forwarding is on, which leaves br0
  # with only a link-local address; accept_ra=2 fixes SLAAC.
  networking.enableIPv6 = true;
  boot.kernel.sysctl = {
    "net.ipv6.conf.br0.accept_ra" = 2;
    "net.ipv6.conf.br0.autoconf" = 1;
  };
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
        8080
        8081
        8090
        27015
      ];
      allowedUDPPorts = [
        6006
        6007
        27015
        27715
      ];
    };
  };
}
