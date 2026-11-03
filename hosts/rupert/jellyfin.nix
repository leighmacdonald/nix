{ username, ... }:
{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = username;
    group = "lusers";
    cacheDir = "/storage/misc/config/jellyfin/cache";
    dataDir = "/storage/misc/config/jellyfin";
    #port = 8096;
  };

}
