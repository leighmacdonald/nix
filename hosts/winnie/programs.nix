{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      gitMinimal
      nano
      wget
      home-manager
      sops
    ];
  };
}
