{ username, ... }:
{
  nixpkgs.config.allowUnsupportedSystem = true;
  nix = {
    settings = {
      #post-build-hook = "/etc/nix/upload-to-cache.sh";
      auto-optimise-store = true;
      trusted-users = [ username ];
      extra-platforms = [
        "aarch64-linux"
        "x86_64-linux"
      ];
      substituters = [
        "https://cache.roto.lol"
        "https://nix-community.cachix.org"
        "https://cache.nixos.org"
        "https://hyprland.cachix.org"
      ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-public-keys = [
        "cache.roto.lol:QN6aF1eT7KvC/lFzLCikuChntrRAEAanO5d91IbTLnY="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
    gc = {
      automatic = true;
      dates = "09:00";
    };
  };

  system = {
    stateVersion = "26.05";
    copySystemConfiguration = false;
  };
}
