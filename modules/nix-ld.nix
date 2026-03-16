{pkgs, ...}: {
  programs = {
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        glibc
        gcc
        freetype
        openssl
        libGL
        stdenv.cc.cc.lib
      ];
    };
  };
}
