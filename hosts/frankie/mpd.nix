let
  listenAddress = "192.168.0.213:6600";
  musicDirectory = "/storage/music/root";
in
{
  services = {
    mpd = {
      enable = true;
      inherit musicDirectory;
      playlistDirectory = "/storage/music/root/playlists";
      dbFile = null; # Must be null when using remote database / stellite mode
      network = {
        startWhenNeeded = false;
        listenAddress = "/tmp/mpd_socket";
      };
      extraConfig = ''
        auto_update "yes"
        auto_update_depth "5"
        database {
          plugin "proxy"
          host "192.168.0.201"
          port "6600"
        }
        audio_output {
          type "pipewire"
          name "PipeWire Sound Server"
        }
        audio_output {
          type "fifo"
          name "Visualizer feed"
          path "/tmp/mpd.fifo"
          format "44100:24:2"
        }
        replaygain  "auto"
        filesystem_charset "UTF-8"
      '';
    };

    mpd-discord-rpc = {
      enable = true;
      settings = {
        hosts = [
          listenAddress
          "/tmp/mpd_socket"
        ];
      };
    };
    mpdris2 = {
      enable = true;
      mpd = {
        inherit musicDirectory;
        host = listenAddress;
      };
    };
  };
}
