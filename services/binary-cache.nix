{
  nix.sshServe = {
    enable = false;
    trusted = true;
    write = true;
    keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPX0V5t0v1XYNOmtGnMOhSZFfRKOW7OighKA+eZGcjSw 2026-leigh.macdonald@gmail.com"
    ];
  };
}
