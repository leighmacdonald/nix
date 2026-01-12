{ inputs, username, ... }:
{
  imports = [ inputs.impermanence.nixosModules.impermanence ];
  sops.secrets = {
    listenbrainz_token = {
      owner = username;
    };
  };
}
