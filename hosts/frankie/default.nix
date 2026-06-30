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
    ./virt.nix
    ./services.nix
    #./ollama.nix
    ./llama-cpp.nix

    ../../env/locale.nix
    ../../env/console.nix
    ../../env/disable_services.nix
    ../../env/no-sudo-pass.nix

    ../../users/leigh.nix

    ../../fs/nfs-mounts.nix

    ../../modules/documentation.nix
    ../../modules/fonts.nix
    ../../modules/nix-ld.nix
    ../../modules/nvidia.nix
    ../../modules/stylix.nix
    ../../modules/secrets.nix
    ../../modules/unfree.nix
    ../../modules/nix.nix

    ../../services/docker.nix
    ../../services/node_exporter.nix
    ../../services/openssh.nix
    ../../services/tailscale.nix
  ];
  # TODO remove
  nixpkgs.config.permittedInsecurePackages = [
    "python3.14-vllm-0.16.0"
  ];
}
