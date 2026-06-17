{
  pkgs ? import <nixpkgs> { },
}:
pkgs.mkShell {
  packages = with pkgs; [
    git
    # npins
    nixos-anywhere
    nixos-rebuild
    ssh-to-age
    age
    nixd
    nil
    nvd
    nixpkgs-fmt
    nixfmt
    statix
    deadnix
    just
    just-lsp
    lua-language-server
  ];
}
