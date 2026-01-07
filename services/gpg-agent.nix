{ pkgs, ... }:
{
  services.gpg-agent = {
    enable = false;
    enableSshSupport = false;
    pinentry.package = pkgs.pinentry-rofi;
  };
}
