{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      gcc
      wget
      libraspberrypi
      libcec
      raspberrypi-eeprom
      home-manager
    ];
  };
}
