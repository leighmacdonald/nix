{ username, inputs, ... }:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    #extraSpecialArgs = inputs // specialArgs;
    users.${username} = import ./home.nix;
  };
}
