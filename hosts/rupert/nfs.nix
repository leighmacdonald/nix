{
  networking.firewall.allowedTCPPorts = [ 2049 ];
  fileSystems = {
    "/storage/music" = {
      device = "music";
      fsType = "zfs";
    };
    "/storage" = {
      device = "media";
      fsType = "zfs";
    };

    "/export/storage" = {
      device = "/storage";
      options = [ "bind" ];
    };

    # "/export/storage/music" = {
    #   device = "/storage/music";
    #   options = [ "bind" ];
    # };

    "/export/backup" = {
      device = "/backup";
      options = [ "bind" ];
    };
  };

  services = {
    rpcbind = {
      enable = true;
    };
    nfs = {
      server = {
        enable = true;
        exports = ''
          /export 192.168.0.0/24(rw,fsid=0,no_subtree_check)
          /export/backup 192.168.0.0/24(rw,nohide,insecure,no_subtree_check)
          /export/storage 192.168.0.0/24(rw,nohide,insecure,no_subtree_check)
          /export/storage/music 192.168.0.0/24(rw,nohide,insecure,no_subtree_check)
        '';
      };
    };
  };
}
