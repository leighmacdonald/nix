{
  sops.secrets."wireless.conf" = {
    path = "/etc/wireless.conf";
    owner = "root";
  };
  networking = {
    wireless = {
      enable = true;
      userControlled = {
        enable = true;
        group = "wheel";
      };
      scanOnLowSignal = false;
      secretsFile = "/etc/wireless.conf";
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
