{
  boot.supportedFilesystems = [ "nfs" ];

  fileSystems = {
    "/mnt/storage" = {
      device = "192.168.0.201:/storage";
      fsType = "nfs";
      options = [
        "async"
        "nfsvers=4.2"
      ];
    };
    "/mnt/storage/music" = {
      device = "192.168.0.201:/storage/music";
      fsType = "nfs";
      options = [
        "async"
        "nfsvers=4.2"
      ];
    };

    "/mnt/backup" = {
      device = "192.168.0.201:/backup";
      fsType = "nfs";
      options = [ "nfsvers=4.2" ];
    };
  };
}
