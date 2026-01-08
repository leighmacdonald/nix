{
  imports = [
    ./programs.nix

    ../../platform/rpi4

    ../../nix.nix

    ../../env/locale.nix
    ../../env/console.nix
    ../../env/disable_services.nix
    ../../env/no-sudo-pass.nix

    ../../users/leigh.nix
    ../../users/root.nix

    ../../fs/nfs.nix

    ../../modules/secrets.nix
    ../../modules/nodocumentation.nix
    ../../modules/stylix.nix
    ../../modules/wifi.nix

    ./caddy.nix

    ../../services/openssh.nix
    ../../services/tailscale.nix
  ];
}
