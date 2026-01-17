{ inputs, ... }:
{
  imports = [ inputs.impermanence.nixosModules.impermanence ];
  sops.secrets = {
  };
}
