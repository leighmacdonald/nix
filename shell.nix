{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  packages = with pkgs; [
    git
    # npins
    nixos-anywhere
    nixos-rebuild
    ssh-to-age
    age
    zellij
    nixd
    nil
    nixpkgs-fmt
    nixfmt
    statix
    deadnix
  ];
}
