{ pkgs, ... }:
{
  # an overlay to enable raspberrypi support in libcec, and thus cec-client
  nixpkgs.overlays = [
    (self: super: { libcec = super.libcec.override { withLibraspberrypi = true; }; })
  ];

  services = {
    udev.extraRules = ''
      KERNEL=="vchiq", GROUP="video", MODE="0660", TAG+="systemd", ENV{SYSTEMD_ALIAS}="/dev/vchiq"
    '';
  };
  systemd = {
    sockets.cec-client = {
      after = [ "dev-vchiq.device" ];
      bindsTo = [ "dev-vchiq.device" ];
      wantedBy = [ "sockets.target" ];
      socketConfig = {
        ListenFIFO = "/run/cec.fifo";
        SocketGroup = "video";
        SocketMode = "0660";
      };
    };
    services.cec-client = {
      after = [ "dev-vchiq.device" ];
      bindsTo = [ "dev-vchiq.device" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = ''${pkgs.libcec}/bin/cec-client -d 1'';
        ExecStop = ''/bin/sh -c "echo q > /run/cec.fifo"'';
        StandardInput = "socket";
        StandardOutput = "journal";
        Restart = "no";
      };
    };
  };
}
