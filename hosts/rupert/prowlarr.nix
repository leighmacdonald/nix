{
  systemd.services.sonarr = {
    requires = [ "postgresql.target" ];
  };
  services.prowlarr = {
    enable = true;
    openFirewall = true;
    environmentFiles = [ "/run/secrets/prowlarr_env" ];
    settings = {
      app = {
        instanceName = "prowlarr";
      };
      server.port = 9696;
      log = {
        analyticsEnabled = false;
      };
      postgres = {
        host = "rupert.roto.lol";
        port = 5432;
        user = "prowlarr";
      };
    };
  };
}
