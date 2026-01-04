{ lib, ... }:
{
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    writebackDevice = "/dev/disk/by-partuuid/1955f56c-be09-114a-bcbe-ca5a5a04e9af";
    memoryPercent = 20;
  };

  swapDevices = lib.mkForce [ ];

  #boot.initrd.systemd.enable = true;
  boot.kernelParams = [
    "systemd.swap=0"
    #"zswap.enabled=1"
    #"zswap.compressor=lz4"
    #"zswap.max_pool_percent=20" # maximum percentage of RAM that zswap is allowed to use
    #"zswap.shrinker_enabled=1" # whether to shrink the pool proactively on high memory pressure
  ];
}
