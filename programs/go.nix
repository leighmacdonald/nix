{ pkgsUnstable, ... }:
{
  programs.go = {
    enable = true;
    telemetry.mode = "off";
    package = pkgsUnstable.go;
  };
}
