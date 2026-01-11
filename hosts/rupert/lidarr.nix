{ username, ... }:
{
  services.lidarr = {
    enable = true;
    openFirewall = true;
    dataDir = "/backup/config/lidarr";
    environmentFiles = [ "/run/secrets/lidarr_env" ];
    user = username;
    group = "lusers";
    settings = {
      log.analyticsEnabled = false;
      server.port = 8686;
      postgres = {
        host = "rupert.roto.lol";
        port = 5432;
        user = "lidarr";
      };
    };
  };
}
