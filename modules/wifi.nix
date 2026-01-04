{
  networking = {
    wireless = {
      enable = true;
      secretsFile = "/run/secrets/wireless.conf";
      networks = {
        badjackie = {
          priority = 1;
          pskRaw = "ext:psk_badjackie";
        };
      };
      interfaces = [ "wlan0" ];
    };
  };
}
