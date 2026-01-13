let
  mode = "666";
in
{
  sops.secrets = {
    prowlarr_env = {
      mode = mode;
    };
    sonarr_env = {
      mode = mode;
    };
    radarr_env = {
      mode = mode;
    };
    lidarr_env = {
      mode = mode;
    };
  };
}
