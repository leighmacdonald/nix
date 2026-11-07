{
  # Explicitly keep IPv6 enabled (default true, but guards against any
  # module disabling it) and accept Router Advertisements on br0 even
  # though IPv6 forwarding is enabled (required for the bridge/VMs).
  # accept_ra=1 ignores RAs when forwarding is on, which leaves br0
  # without a default route; accept_ra=2 fixes that.
  #
  # The ISP router does not offer SLAAC (RA has autonomous=off) and its
  # DHCPv6 server answers "No addresses available for this interface",
  # so the global address is pinned statically in the on-link /64 that
  # the router advertises. Update the prefix here if the ISP renumbers.
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
        ipv6.addresses = [
          {
            address = "2001:56a:7426:6d00::200";
            prefixLength = 64;
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
