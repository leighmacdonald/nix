{
  imports = [
    ./audio.nix
    ./boot.nix
    ./cec.nix
    # ./disk.nix
    ./filesystem.nix
    ./hardware.nix
    ./hardware-configuration.nix
    ./network.nix

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
