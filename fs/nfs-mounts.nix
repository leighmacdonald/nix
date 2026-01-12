let
  nfsServer = "rupert.roto.lol";
in
{
  boot.supportedFilesystems = [ "nfs" ];
  services.rpcbind.enable = true;
  systemd.mounts =
    let
      common = {
        type = "nfs";
        mountConfig = {
          Options = "async,nfsvers=4.2";
        };
      };
    in
    [
      (
        common
        // {
          what = "${nfsServer}:/storage";
          where = "/storage/";
        }
      )
      (
        common
        // {
          what = "${nfsServer}:/storage/music";
          where = "/storage/music";
        }
      )
      (
        common
        // {
          what = "${nfsServer}:/backup";
          where = "/backup/";
        }
      )
    ];

  systemd.automounts =
    let
      commonMount = {
        wantedBy = [ "multi-user.target" ];
        automountConfig = {
          TimeoutIdleSec = "600";
        };
      };
    in
    [
      (commonMount // { where = "/storage"; })
      (commonMount // { where = "/storage/music"; })
      (commonMount // { where = "/backup"; })
    ];
}
