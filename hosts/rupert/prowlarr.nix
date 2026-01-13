{
  services.prowlarr = {
    enable = true;
    openFirewall = true;
    dataDir = "/backup/config/prowlarr/data";
    environmentFiles = [ "/run/secrets/prowlarr_env" ];
    settings = {
      app = {
        instanceName = "prowlarr";
      };
      auth = {
        enabled = false;
        method = "None";
        required = false;
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
