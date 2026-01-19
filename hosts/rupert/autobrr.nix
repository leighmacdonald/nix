{
  sops = {
    secrets = {
      "autobrr_session_key" = {
        mode = "666";
      };
    };
  };

  services.autobrr = {
    enable = true;
    openFirewall = true;
    secretFile = "/run/secrets/autobrr_session_key";
    settings = {
      checkForUpdates = false;
      host = "0.0.0.0";
      port = 7474;
      metricsEnabled = true;
    };
  };
}
