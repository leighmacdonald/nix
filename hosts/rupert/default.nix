{
  inputs,
  ...
}:
{
  imports = [
    inputs.disko.nixosModules.disko

    ./hardware-configuration.nix

    ../../nix.nix
    ../../env/locale.nix
    ../../env/console.nix
    ../../env/disable_services.nix
    ../../users/root.nix
    ../../users/leigh.nix
    ../../modules/nodocumentation.nix
    ../../modules/secrets.nix

    ../../services/docker.nix
    ../../services/node_exporter.nix
    ../../services/openssh.nix
    ../../services/tailscale.nix
  ];

  hardware = {
    bluetooth.enable = false;
    enableAllFirmware = false;
  };

  nixpkgs.config.allowUnfree = false;

}
