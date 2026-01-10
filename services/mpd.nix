{ config, ... }:

let
  # local socket allows `rmpc addyt` to function.
  listenAddress = "/tmp/mpd_socket";
  musicDirectory = "/mnt/storage/music";
in
{
  imports = [
    ../env/email.nix
  ];
  services = {
    mpd-discord-rpc.enable = true;
    mpdris2 = {
      enable = true;
      mpd = {
        host = listenAddress;
        musicDirectory = musicDirectory;
      };
    };

    mpd = {
      enable = true;
      network.startWhenNeeded = false;
      network.listenAddress = listenAddress;
      musicDirectory = musicDirectory;
      playlistDirectory = "${musicDirectory}/_playlists";
      dbFile = "~/.config/mpd/database";
      extraConfig = ''
        sticker_file                    "~/.config/mpd/sticker.sql"
        save_absolute_paths_in_playlists        "yes"
        auto_update     "yes"
        auto_update_depth "3"
        follow_outside_symlinks "no"
        follow_inside_symlinks          "yes"
        audio_output {
            type            "pipewire"
            name            "PipeWire Sound Server"
        }
        audio_output {
            type            "fifo"
            name            "Visualizer feed"
            path            "/tmp/mpd.fifo"
            format          "44100:24:2"
        }
        replaygain                      "auto"
        filesystem_charset              "UTF-8"
      '';
    };
    mpdscribble = {
      enable = true;
      host = listenAddress;
      endpoints = {
        "last.fm" = {
          passwordFile = "/run/secrets/lastfm";
          username = config.accounts.email.accounts.default.address;
        };
      };
    };
  };
}
