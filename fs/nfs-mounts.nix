{
  boot.supportedFilesystems = [ "nfs" ];

  fileSystems = {
    "/mnt/storage" = {
      device = "rupert.roto.lol:/storage";
      fsType = "nfs";
      options = [
        "async"
        "nfsvers=4.2"
      ];
    };
    "/mnt/storage/music" = {
      device = "rupert.roto.lol:/storage/music";
      fsType = "nfs";
      options = [
        "async"
        "nfsvers=4.2"
      ];
    };

    "/mnt/backup" = {
      device = "rupert.roto.lol:/backup";
      fsType = "nfs";
      options = [ "nfsvers=4.2" ];
    };
  };
}
