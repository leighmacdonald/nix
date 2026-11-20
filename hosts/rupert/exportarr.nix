{ config, ... }:
{
  # Prometheus exporters for the *arr stack. Each instance scrapes its local
  # service and exposes /metrics. The firewall only opens these ports on
  # tailscale0 (which is also a trusted interface), so they are reachable over
  # Tailscale but not from the LAN or the public internet.
  networking.firewall.interfaces.tailscale0.allowedTCPPorts = [
    9708
    9709
    9710
    9711
  ];

  services.prometheus.exporters = {
    exportarr-sonarr = {
      enable = true;
      port = 9708;
      listenAddress = "0.0.0.0";
      # The NixOS exporter module does not wire `listenAddress` through to
      # exportarr, so set the binary's own INTERFACE variable explicitly.
      environment.INTERFACE = "0.0.0.0";
      url = "http://127.0.0.1:8989";
      apiKeyFile = config.sops.secrets.sonarr_api_key.path;
    };
    exportarr-radarr = {
      enable = true;
      port = 9709;
      listenAddress = "0.0.0.0";
      environment.INTERFACE = "0.0.0.0";
      url = "http://127.0.0.1:7878";
      apiKeyFile = config.sops.secrets.radarr_api_key.path;
    };
    exportarr-lidarr = {
      enable = true;
      port = 9710;
      listenAddress = "0.0.0.0";
      environment.INTERFACE = "0.0.0.0";
      url = "http://127.0.0.1:8686";
      apiKeyFile = config.sops.secrets.lidarr_api_key.path;
    };
    exportarr-prowlarr = {
      enable = true;
      port = 9711;
      listenAddress = "0.0.0.0";
      environment.INTERFACE = "0.0.0.0";
      url = "http://127.0.0.1:9696";
      apiKeyFile = config.sops.secrets.prowlarr_api_key.path;
    };
  };
}
