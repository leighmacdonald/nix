{
  disko.devices.disk.main = {
    type = "disk";
    # Dont actually format anything as we start with formatted sdcard base images.
    destroy = false;
    device = "/dev/disk/by-uuid/44444444-4444-4444-8888-888888888888";
    content = {
      type = "gpt";
      partitions = {
        MBR = {
          priority = 0;
          size = "1M";
          type = "EF02";
        };
        ESP = {
          priority = 1;
          size = "30M";
          type = "EF00";
          content = {
            device = "/dev/disk/by-uuid/2178-694E";
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot/firmware";
          };
        };
        root = {
          priority = 2;
          size = "100%";
          content = {
            device = "/dev/disk/by-uuid/44444444-4444-4444-8888-888888888888";
            type = "filesystem";
            format = "ext4";
            mountpoint = "/";
          };
        };
      };
    };
  };
}
