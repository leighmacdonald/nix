{

  services.jellyseerr = {
    enable = true;
    openFirewall = true;
    configDir = "/backup/config/jellyseerr";
    port = 5055;
  };
}
