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
    listenbrainz_token = {
      owner = username;
    };
    "beets.yaml" = {
      owner = username;
      mode = "777"; # FIXME
    };
  };
}
