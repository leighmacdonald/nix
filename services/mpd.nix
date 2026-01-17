{
  pkgs,
  username,
  ...
}:
let
  # local socket allows `rmpc addyt` to function.
  listenAddress = "rupert.roto.lol";
  port = 6600;
  musicDirectory = "/storage/music/root";
in
{
  environment = {
    systemPackages = with pkgs; [
      mp3val
      flac
      imagemagick
      gst_all_1.gst-libav
      chromaprint
      (python3.withPackages (python-pkgs: [ python-pkgs.pyacoustid ]))
      atop
    ];
  };
  services = {
    mpd = {
      enable = true;
      openFirewall = true;
      startWhenNeeded = false;
      user = username;
      settings = {
        bind_to_address = listenAddress;
        port = port;
        music_directory = musicDirectory;
        sticker_file = "/storage/music/.sticker.sql";
        save_absolute_paths_in_playlists = "yes";
        playlist_directory = "/storage/music/root/playlists";
        #db_file = "${musicDirectory}/database";

        follow_outside_symlinks = "yes";
        follow_inside_symlinks = "yes";

      };
    };
    mpdscribble = {
      enable = true;
      host = listenAddress;
      port = port;
      endpoints = {
        "listenbrainz" = {
          passwordFile = "/run/secrets/listenbrainz_token";
          username = "rotorooter";
        };
        "last.fm" = {
          passwordFile = "/run/secrets/lastfm";
          username = "leigh.macdonald@gmail.com";
        };
      };
    };
  };
}
