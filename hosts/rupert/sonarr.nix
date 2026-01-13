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
#  id |              identifier              | username |                   password                   |           salt           | iterations
#----+--------------------------------------+----------+----------------------------------------------+--------------------------+------------
# 1 | f4c654bd-c581-48f0-976b-e5416c570af1 | roto     | R1rbcwmkVaGk2Z0Hs1GKOn8xbBrz1IXyvqX2SC7Vbu4= | GTyYP3Fdri5JsjaFNHh3Nw== |      10000
