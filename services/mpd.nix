{ pkgs, username, ... }:
let
  # local socket allows `rmpc addyt` to function.
  listenAddress = "any";
  musicDirectory = "/storage/music/root";
in
{
  environment = {
    systemPackages = with pkgs; [
      mp3val
      flac
      imagemagick
      gst_all_1.gst-libav
    ];
  };
  services = {
    mpd = {
      enable = true;
      openFirewall = true;
      startWhenNeeded = true;
      user = username;
      settings = {
        bind_to_address = listenAddress;
        music_directory = musicDirectory;
        sticker_file = "${musicDirectory}/../sticker.sql";
        save_absolute_paths_in_playlists = "yes";
        playlist_directory = "${musicDirectory}/../playlists";
        #db_file = "${musicDirectory}/database";
        auto_update = "yes";
        auto_update_depth = "3";
        follow_outside_symlinks = "yes";
        follow_inside_symlinks = "yes";
        audio_output = [
          {
            type = "pipewire";
            name = "PipeWire Sound Server";
          }
          {
            type = "fifo";
            name = "Visualizer feed";
            path = "/tmp/mpd.fifo";
            format = "44100:24:2";
          }
        ];
        replaygain = "auto";
        filesystem_charset = "UTF-8";
      };
    };
  };
}
