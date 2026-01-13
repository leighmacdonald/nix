{
  pkgs ? import <nixpkgs> { },
}:

(pkgs.buildFHSEnv {
  name = "zed-env";
  targetPkgs =
    pkgs:
    (with pkgs; [
      udev
      alsa-lib
    ])
    ++ (with pkgs.xorg; [
      libX11
      libXcursor
      libXrandr
    ]);
  multiPkgs =
    pkgs:
    (with pkgs; [
      udev
      alsa-lib
    ]);
  runScript = "zeditor";
}).env
