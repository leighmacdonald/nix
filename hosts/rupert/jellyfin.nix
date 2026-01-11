{ username, ... }:
{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = username;
    group = "lusers";
    cacheDir = "/backup/config/jellyfin/cache";
    dataDir = "/backup/config/jellyfin";
    #port = 8096;
  };

}
