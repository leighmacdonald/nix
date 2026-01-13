{ pkgs, config, ... }:
{
  users = {
    defaultUserShell = pkgs.bash;
    users.root = {
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPX0V5t0v1XYNOmtGnMOhSZFfRKOW7OighKA+eZGcjSw 2026-leigh.macdonald@gmail.com"
      ];
      home = "/root";
      shell = pkgs.bash;
      hashedPasswordFile = config.sops.secrets.password.path;
    };
  };
}
