{ username, ... }:

let
  mode = "666";
in
{
  sops.secrets = {
    prowlarr_env = {
      inherit mode;
    };
    sonarr_env = {
      inherit mode;
    };
    radarr_env = {
      inherit mode;
    };
    lidarr_env = {
      inherit mode;
    };
    "beets.yaml" = {
      owner = username;
    };
  };
}
