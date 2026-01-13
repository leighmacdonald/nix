{
  networking.firewall.allowedTCPPorts = [ 2049 ];

  fileSystems = {
    # "/export/storage" = {
    #   device = "/storage";
    #   options = [ "bind" ];
    # };

    # "/export/music" = {
    #   device = "/music";
    #   options = [ "bind" ];
    # };

    "/export/backup" = {
      device = "/backup";
      options = [ "bind" ];
    };
  };

  services.nfs = {
    settings = {
      nfsd = {
        "vers3" = false;
        "vers4" = false;
        "vers4.0" = false;
        "vers4.1" = false;
        "vers4.2" = true;
      };
    };
    server = {
      enable = true;
      exports = ''
          /export 192.168.0.0/24(rw,fsid=0,no_subtree_check)
          /export/backup 192.168.0.0/24(rw,nohide,insecure,no_subtree_check)
        #   #/export/storage 192.168.0.0/24(rw,nohide,insecure,no_subtree_check,)
        #   #/export/music 192.168.0.0/24(rw,nohide,insecure,no_subtree_check)
      '';
    };
  };
}
