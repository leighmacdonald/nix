{
  lib,
  pkgs,
  username,
  ...
}:

{
  imports = [
    ./programs.nix

    ../../platform/rpi2

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

    ../../services/openssh.nix
    ../../services/tailscale.nix
  ];

  users.users.${username}.shell = lib.mkForce pkgs.bash;
}
