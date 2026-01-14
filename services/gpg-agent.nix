{ pkgs, ... }:
{
  services.gpg-agent = {
    enable = true;
    enableSshSupport = false;
    pinentry.package = pkgs.pinentry-rofi;
  };
}
