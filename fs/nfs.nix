{
  boot.supportedFilesystems = [ "nfs" ];
  systemd.mounts = [
    {
      type = "nfs";
      mountConfig = {
        Options = "noatime";
      };
      what = "192.168.0.201:/backup";
      where = "/mnt/backup";
    }
    {
      type = "nfs";
      mountConfig = {
        Options = "noatime";
      };
      what = "192.168.0.201:/storage";
      where = "/mnt/storage";
    }
    {
      type = "nfs";
      mountConfig = {
        Options = "noatime";
      };
      what = "192.168.0.201:/storage/music";
      where = "/mnt/storage/music";

    }
  ];
  systemd.automounts = [
    {
      wantedBy = [ "multi-user.target" ];
      automountConfig = {
        TimeoutIdleSec = "3600";
      };
      where = "/mnt/backup";
    }
    {
      wantedBy = [ "multi-user.target" ];
      automountConfig = {
        TimeoutIdleSec = "3600";
      };
      where = "/mnt/storage";
    }
    {
      wantedBy = [ "multi-user.target" ];
      automountConfig = {
        TimeoutIdleSec = "3600";
      };
      where = "/mnt/storage/music";
    }
  ];
}
