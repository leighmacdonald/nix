{ hostName, ... }:
{
  networking = {
    hostName = hostName;

    firewall = {
      enable = true;
    };
  };
}
