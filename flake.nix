{
  description = "NixOS configuration";

  inputs = {
    impermanence.url = "github:nix-community/impermanence";
    
    nixcord.url = "github:4evy/nixcord";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    home-manager.url = "github:nix-community/home-manager/release-26.05";

    stylix = {
      url = "github:nix-community/stylix/release-26.05";
      # inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    llm-agents.url = "github:numtide/llm-agents.nix";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvim.url = "github:leighmacdonald/nvim";

    # obs-mpd-status.url = "path:/projects/obs-mpd-status";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      llm-agents,
      stylix,
      nvim,
      ...
    }@inputs:
    let
      username = "leigh";
    in
    {
      nixosConfigurations = {
        frankie =
          let
            hostName = "frankie";
            specialArgs = {
              inherit username;
              inherit hostName;
              inherit inputs;
              # inherit llm-agents;
              inherit nvim;
              pkgsUnstable = import inputs.nixpkgs-unstable {
                system = "x86_64-linux";
                config = {
                  allowUnfree = true;
                };
              };
            };
          in
          nixpkgs.lib.nixosSystem {
            inherit specialArgs;
            system = "x86_64-linux";
            modules = [
              { nixpkgs.overlays = [ llm-agents.overlays.shared-nixpkgs ]; }
              # hyprland.homeManagerModules.default
              ./hosts/${hostName}
              {
                home-manager = {
                  extraSpecialArgs = inputs // specialArgs;
                };
              }
            ];
          };

        rupert =
          let
            hostName = "rupert";
            specialArgs = {
              inherit username;
              inherit hostName;
              inherit inputs;
            };
          in
          nixpkgs.lib.nixosSystem {
            inherit specialArgs;
            system = "x86_64-linux";
            modules = [
              ./hosts/${hostName}
              stylix.nixosModules.stylix
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  extraSpecialArgs = inputs // specialArgs;
                  users.${username} = import ./hosts/${hostName}/home.nix;
                };
              }
            ];
          };
      };
    };
}
