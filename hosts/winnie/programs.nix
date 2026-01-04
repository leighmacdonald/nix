{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      gitMinimal
      #neovim
      wget
      #libraspberrypi
      #raspberrypi-eeprom
      home-manager
      cifs-utils
    ];
  };

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
    fish.enable = true;
  };
}
