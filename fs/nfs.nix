let
  mountOpts = [
    "nfsvers=4.2"
    #"x-systemd.automount"
    #"x-systemd.idle-timeout=3600"
    #"noauto"
    "noatime"
    "rsize=131072"
    "wsize=131072"
    "noacl"
    "nodiratime"
  ];
in {
  #fileSystems."/mnt/storage" = {
  #    device = "192.168.0.201:/storage";
  #    fsType = "nfs";
  #    options = mountOpts;
  #  };

  #  fileSystems."/mnt/backup" = {
  #    device = "192.168.0.201:/backup";
  #    fsType = "nfs";
  #    options = mountOpts;
  #  };
  # optional, but ensures rpc-statsd is running for on demand mounting
  boot.supportedFilesystems = ["nfs"];
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
  ];
  systemd.automounts = [
    {
      wantedBy = ["multi-user.target"];
      automountConfig = {
        TimeoutIdleSec = "3600";
      };
      where = "/mnt/backup";
    }
    {
      wantedBy = ["multi-user.target"];
      automountConfig = {
        TimeoutIdleSec = "3600";
      };
      where = "/mnt/storage";
    }
  ];
}
