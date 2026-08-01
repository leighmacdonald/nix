{
  lib,
  ...
}:
{
  documentation = {
    enable = lib.mkDefault true;
    dev.enable = true;
    doc.enable = true;
    info.enable = true;
    # Needed for fancy fish man page integration i assume?
    nixos.enable = true;
  };
}
