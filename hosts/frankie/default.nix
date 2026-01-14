{
  imports = [
    ./audio.nix
    ./boot.nix
    ./disko.nix
    ./hardware.nix
    ./home-manager.nix
    ./network.nix
    ./nixpkgs.nix
    ./programs.nix
    ./persistence.nix
    ./secrets.nix
    ./stylix.nix

    ../../nix.nix

    ../../env/locale.nix
    ../../env/console.nix
    ../../env/disable_services.nix
    ../../env/no-sudo-pass.nix

    ../../users/leigh.nix

    ../../fs/nfs-mounts.nix

    ../../modules/documentation.nix
    ../../modules/fonts.nix
    ../../modules/nvidia.nix
    ../../modules/stylix.nix
    ../../modules/secrets.nix
    ../../modules/unfree.nix
    # ../../modules/zram.nix

    ../../services/docker.nix
    ../../services/node_exporter.nix
    ../../services/openssh.nix
    ../../services/tailscale.nix
  ];
}
