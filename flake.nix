{
  description = "NixOS configuration";

  inputs = {
    impermanence = {
      url = "github:nix-community/impermanence";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };

    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    };

    hy3 = {
      url = "github:outfoxxed/hy3";
      inputs.hyprland.follows = "hyprland";
    };

    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord = {
      url = "github:kaylorben/nixcord";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      stylix,
      hyprland,
      ...
    }@inputs:
    let
      username = "leigh";
    in
    {
      nixosConfigurations = {
        # armv7l is not that well supported
        #
        # mika =
        #   let
        #     hostName = "mika";
        #     specialArgs = {
        #       inherit username;
        #       inherit hostName;
        #       inherit inputs;
        #     };
        #   in
        #   nixpkgs.lib.nixosSystem {
        #     inherit specialArgs;
        #     system = "armv7l-linux";
        #     modules = [
        #       stylix.nixosModules.stylix
        #       ./hosts/${hostName}
        #       home-manager.nixosModules.home-manager
        #       {
        #         home-manager = {
        #           useGlobalPkgs = true;
        #           useUserPackages = true;
        #           extraSpecialArgs = inputs // specialArgs;
        #           users.${username} = import ./hosts/${hostName}/home.nix;
        #         };
        #       }
        #     ];
        #   };
        phyllis =
          let
            hostName = "phyllis";
            specialArgs = {
              inherit username;
              inherit hostName;
              inherit inputs;
            };
          in
          nixpkgs.lib.nixosSystem {
            inherit specialArgs;
            system = "aarch64-linux";
            modules = [
              stylix.nixosModules.stylix
              ./hosts/${hostName}
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
        winnie =
          let
            hostName = "winnie";
            specialArgs = {
              inherit username;
              inherit hostName;
              inherit inputs;
            };
          in
          nixpkgs.lib.nixosSystem {
            inherit specialArgs;
            system = "aarch64-linux";
            modules = [
              inputs.disko.nixosModules.disko
              stylix.nixosModules.stylix
              ./hosts/${hostName}
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

        # frankieiso =
        #   let
        #     hostName = "frankie";
        #     specialArgs = {
        #       inherit username;
        #       inherit hostName;
        #       inherit inputs;
        #     };
        #   in
        #   nixpkgs.lib.nixosSystem {
        #     modules = [
        #       #"${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-gnome.nix"
        #       #"${nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
        #       ./hosts/${hostName}
        #     ];
        #     inherit specialArgs;
        #   };

        frankie =
          let
            hostName = "frankie";
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
