{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      gitMinimal
      wget
      #libraspberrypi
      #raspberrypi-eeprom
      home-manager
      sops
    ];
  };

  programs = {
    neovim = {
      enable = false;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
    fish.enable = false;
  };
}
