{ username, ... }:
{
  services.radarr = {
    enable = true;
    openFirewall = true;
    dataDir = "/backup/config/radarr";
    environmentFiles = [ "/run/secrets/radarr_env" ];
    user = username;
    group = "lusers";
    settings = {
      log.analyticsEnabled = false;
      server.port = 7878;
      auth = {
        enabled = false;
        method = "None";
        required = false;
      };
      postgres = {
        host = "rupert.roto.lol";
        port = 5432;
        user = "radarr";
      };
    };
  };
}
