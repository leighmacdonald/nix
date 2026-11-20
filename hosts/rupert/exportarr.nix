{ config, ... }:
{
  # Prometheus exporters for the *arr stack. Each instance scrapes its local
  # service and exposes /metrics on a loopback-only port.
  services.prometheus.exporters = {
    exportarr-sonarr = {
      enable = true;
      port = 9708;
      listenAddress = "127.0.0.1";
      url = "http://127.0.0.1:8989";
      apiKeyFile = config.sops.secrets.sonarr_api_key.path;
    };
    exportarr-radarr = {
      enable = true;
      port = 9709;
      listenAddress = "127.0.0.1";
      url = "http://127.0.0.1:7878";
      apiKeyFile = config.sops.secrets.radarr_api_key.path;
    };
    exportarr-lidarr = {
      enable = true;
      port = 9710;
      listenAddress = "127.0.0.1";
      url = "http://127.0.0.1:8686";
      apiKeyFile = config.sops.secrets.lidarr_api_key.path;
    };
    exportarr-prowlarr = {
      enable = true;
      port = 9711;
      listenAddress = "127.0.0.1";
      url = "http://127.0.0.1:9696";
      apiKeyFile = config.sops.secrets.prowlarr_api_key.path;
    };
  };
}
