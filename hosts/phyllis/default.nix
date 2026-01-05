{
  ...
}:

{
  imports = [
    ./network.nix
    ./cec.nix
    ./hardware.nix
    ./audio.nix
    ./display-manager.nix
    ./programs.nix

    ../../nix.nix

    ../../hardware/rpi4

    ../../env/locale.nix
    ../../env/console.nix
    ../../env/disable_services.nix
    ../../env/no-sudo-pass.nix

    ../../users/root.nix
    ../../users/leigh.nix
    ../../modules/wifi.nix
    ../../fs/nfs.nix

    ../../services/openssh.nix
    ../../services/tailscale.nix
  ];
}
