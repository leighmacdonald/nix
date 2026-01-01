{ pkgs, ... }:
{
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableBashIntegration = true;
    pinentry.package = pkgs.pinentry-rofi;
  };
}
