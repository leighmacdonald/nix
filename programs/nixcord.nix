{ inputs, ... }:
{
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];

  stylix.targets.nixcord.enable = true;
  programs.nixcord = {
    enable = true;
    discord = {
      equicord.enable = false;
      vencord.enable = false;
      branch = "canary";

    };
    vesktop.enable = true;
  };
}
