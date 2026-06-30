{ pkgs, ... }:
{
  services.lact.enable = true;
  services.udev.packages = [ pkgs.system76-keyboard-configurator ];
}
