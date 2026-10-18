{
  lib,
  ...
}:
{
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep-since 14d --keep 3 --keep-one";
    };
  };

  # nh clean replaces the nix-gc timer; enabling both is warned against.
  nix.gc.automatic = lib.mkForce false;
}
