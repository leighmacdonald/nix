{
  description = "NixOS configuration";

  inputs = {
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-25.11";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
    };

    stylix = {
      url = "github:nix-community/stylix/release-25.11";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
    };

    hypridle = {
      url = "github:hyprwm/hypridle";
      inputs = {
        hyprlang.follows = "hyprland/hyprlang";
        hyprutils.follows = "hyprland/hyprutils";
        nixpkgs.follows = "hyprland/nixpkgs";
        systems.follows = "hyprland/systems";
      };
    };

    hyprshutdown = {
      url = "github:hyprwm/hyprshutdown";
      inputs = {
        hyprutils.follows = "hyprland/hyprutils";
        nixpkgs.follows = "hyprland/nixpkgs";
        systems.follows = "hyprland/systems";
      };
    };

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "hyprland/nixpkgs";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs = {
        hyprgraphics.follows = "hyprland/hyprgraphics";
        hyprlang.follows = "hyprland/hyprlang";
        hyprutils.follows = "hyprland/hyprutils";
        nixpkgs.follows = "hyprland/nixpkgs";
        systems.follows = "hyprland/systems";
      };
    };

    hyprpaper = {
      url = "github:hyprwm/hyprpaper";
      inputs = {
        aquamarine.follows = "hyprland/aquamarine";
        hyprgraphics.follows = "hyprland/hyprgraphics";
        hyprlang.follows = "hyprland/hyprlang";
        hyprutils.follows = "hyprland/hyprutils";
        hyprwire.follows = "hyprland/hyprwire";
        nixpkgs.follows = "hyprland/nixpkgs";
        systems.follows = "hyprland/systems";
      };
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
      nixos-hardware,
      stylix,
      ...
    }@inputs:
    let
      username = "leigh";
    in
    {
      nixosConfigurations = {
        bedroom =
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
              nixos-hardware.nixosModules.raspberry-pi-4
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
              nixos-hardware.nixosModules.raspberry-pi-4
            ];
          };
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
              ./hosts/${hostName}
              #sops-nix.nixosModules.sops
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
