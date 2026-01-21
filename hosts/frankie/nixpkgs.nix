{lib, ...}: {
  nixpkgs = {
    hostPlatform = lib.mkForce "x86_64-linux";
    config.allowUnfree = true;
  };
}
