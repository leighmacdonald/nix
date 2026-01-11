{ username, ... }:
{
  services.bazarr = {
    enable = true;
    openFirewall = true;
    dataDir = "/backup/config/bazarr";
    user = username;
    listenPort = 6767;
    group = "lusers";
  };
}
