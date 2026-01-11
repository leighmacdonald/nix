{ username, ... }:
{
  services.sonarr = {
    enable = true;
    openFirewall = true;
    dataDir = "/backup/config/sonarr";
    environmentFiles = [ "/run/secrets/sonarr_env" ];
    user = username;
    group = "lusers";
    # SONARR__AUTH__APIKEY
    # SONARR__POSTGRES__PASSWORD
    settings = {
      log.analyticsEnabled = false;
      server.port = 8989;
      postgres = {
        host = "rupert.roto.lol";
        port = 5432;
        user = "sonarr";
      };
    };
  };
}
