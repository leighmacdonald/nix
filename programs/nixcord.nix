{ nixcord, ... }:
{
  imports = [
    nixcord.homeModules.nixcord
  ];

  stylix.targets.nixcord.enable = true;
  programs.nixcord = {
    enable = true;
    discord = {
      vencord.enable = true;
    };
    vesktop.enable = true;
  };
}
