{
  services.autobrr = {
    enable = true;
    openFirewall = true;
    secretFile = "/run/secrets/autobrr";
    settings = {
      checkForUpdates = true;
      host = "0.0.0.0";
      port = 7474;
    };
  };
}
