{
  pkgs ? import <nixpkgs> { },
}:
pkgs.mkShell {
  packages = with pkgs; [
    npins
    nixos-anywhere
    nixos-rebuild
    ssh-to-age
    age
  ];
}
