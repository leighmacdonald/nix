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
      postgres = {
        host = "rupert.roto.lol";
        port = 5432;
        user = "radarr";
      };
    };
  };
}
