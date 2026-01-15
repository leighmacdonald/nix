{ config, ... }:
{
  # mp3val / flac tools imagemagick gstreamer
  programs.beets = {
    enable = true;
    modIntegration = {
      mpdStats = true;
      enableUpdate = true;
      host = "rupert.roto.lol";
      port = 6600;
    };
    settings = {
      plugins = [
        "listenbrainz"
        "musicbrainz"
        "autobpm"
        "badfiles"
        "discogs"
        "embedart"
        "fetchart"
        "thumbnails"
        "fish"
        "fromfilename"
        "importfeeds"
        "lyrics"
        "mpdstats"
        "mpdupdate"
        "smartplaylist"
        "types"
      ];
      types = {
        rating = "int";
      };
      importfeeds = {
        formats = [
          "m3u"
        ];
        dir = "/storage/music";
        relative_to = "/storage/music/managed";
        m3u_name = "latest.m3u";
      };
      mpd = {
        host = "rupert.roto.lol";
        port = config.services.mpd.port;
        #password: "";
      };
      mpdstats = {
        host = "rupert.roto.lol";
        port = config.services.mpd.port;
        # password = "";
        # music_directory = "";
        #strip_path = "/storage/music/managed";
        rating = true;
      };
      lyrics = {
        auto = true;
        dist_thresh = 0.11;
        fallback = null;
        force = false;
        google_API_key = null;
        google_engine_ID = "009217259823014548361:lndtuqkycfu";
        print = false;
        sources = [
          "lrclib"
          "google"
          "genius"
          "tekstowo"
        ];
        synced = true;
      };
      listenbrainz = {
        token = "TOKEN";
        username = "LISTENBRAINZ_USERNAME";
      };
      loadext = [ "libicu" ];
      musicbrainz = {
        auto = true;
        user = "your_musicbrainz_username";
        password = "your_musicbrainz_password";
      };
      # discogs = {
      #   user_token = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
      # };
    };
  };

}
