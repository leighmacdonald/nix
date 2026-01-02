{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      neovim
      wget
      libraspberrypi
      libcec
      raspberrypi-eeprom
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
    thunar.enable = true;
    appimage = {
      enable = true;
      binfmt = true;
    };
    fish.enable = true;
  };
}
