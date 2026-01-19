{
  sops = {
    secrets = {
      "ddns-updater.conf" = {
        mode = "666";
      };
    };
  };
  services.ddns-updater = {
    enable = true;
    environment = {
      PERIOD = "5m";
      SERVER_ENABLED = "no";
      CONFIG_FILEPATH = "/run/secrets/ddns-updater.conf";
    };
  };
}
