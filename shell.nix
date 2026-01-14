{
  pkgs ? import <nixpkgs> { },
}:
pkgs.mkShell {
  packages = with pkgs; [
    git
    npins
    nixos-anywhere
    nixos-rebuild
    ssh-to-age
    age
    pgloader
    zellij
  ];
}
