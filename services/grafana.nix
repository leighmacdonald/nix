{
  services.grafana = {
    enable = true;
    settings = {
      server = {
        http_addr = "192.168.0.201";
        http_port = 3000;
        enforce_domain = true;
        enable_gzip = true;
        domain = "metrics.roto.lol";
      };

      analytics.reporting_enabled = false;
    };
  };
}
