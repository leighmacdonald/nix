{ pkgs, ... }:
{
  imports = [
    ./programs.nix
    ./display-manager.nix

    ../../nix.nix

    ../../platform/rpi4
    ../../modules/secrets.nix
    ../../modules/stylix.nix
  ];

  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/heetch.yaml";
  };

  networking.interfaces.end0 = {
    ipv4 = {
      #useDHCP = lib.mkForce false;
      addresses = [
        {
          address = "192.168.0.100";
          prefixLength = 24;
        }
      ];
      routes = [
        {
          address = "192.168.0.0";
          prefixLength = 24;
          via = "192.168.0.1";
        }
      ];
    };
  };
}
