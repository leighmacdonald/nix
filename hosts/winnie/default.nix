{
  ...
}:

{
  imports = [
    ./audio.nix
    ./hardware.nix
    ./programs.nix

    ../../hardware/rpi4

    ../../nix.nix

    ../../env/locale.nix
    ../../env/console.nix
    ../../env/disable_services.nix
    ../../env/no-sudo-pass.nix

    ../../users/leigh.nix
    ../../users/root.nix

    ../../fs/cifs.nix

    ../../modules/secrets.nix
    ../../modules/nodocumentation.nix
    ../../modules/stylix.nix
    ../../modules/wifi.nix

    ../../services/openssh.nix
    ../../services/tailscale.nix
  ];
}
