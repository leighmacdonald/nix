{ username, ... }:
{
  systemd.services.sonarr = {
    requires = [ "postgresql.target" ];
  };
  services.sonarr = {
    enable = true;
    openFirewall = true;
    environmentFiles = [ "/run/secrets/sonarr_env" ];
    user = username;
    group = "lusers";
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
