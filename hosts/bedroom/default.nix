{
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./network.nix
    ./cec.nix
    ./hardware.nix
    ./filesystem.nix
    ./audio.nix
    ./display-manager.nix
    ./programs.nix

    ../../nix.nix

    ../../env/locale.nix
    ../../env/console.nix
    ../../env/disable_services.nix
    ../../env/no-sudo-pass.nix

    ../../users/leigh.nix
    ../../fs/cifs.nix

    ../../services/openssh.nix
    ../../services/tailscale.nix
  ];
}
