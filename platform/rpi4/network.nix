{ hostName, ... }:
{
  networking = {
    hostName = hostName;
    dhcpcd = {
      enable = true;
      allowSetuid = true;
    };
    interfaces = {
      end0 = {
        useDHCP = true;
      };
      wlan0 = {
        useDHCP = true;
      };
    };
    firewall = {
      enable = true;
    };
  };
}
