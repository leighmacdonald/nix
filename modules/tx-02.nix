{ pkgs, ... }:
let
  tx-02 = pkgs.stdenv.mkDerivation {
    pname = "tx-02";
    version = "1.0";

    src = ../fonts/TX-02;

    dontPatch = true;
    dontConfigure = true;
    dontBuild = true;
    doCheck = false;
    dontFixup = true;

    installPhase = ''
         runHook preInstall
         install -Dm644 -t $out/share/fonts/opentype/ *.otf
      	 runHook postInstall
    '';
  };
in
{
  # Enable fontconfig to discover the fonts
  fonts.fontconfig.enable = true;

  # Add the custom TX-02 package to system fonts
  home.packages = [
    tx-02
  ];
}
