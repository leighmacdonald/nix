{
  # mp3val / flac tools imagemagick gstreamer
  programs.beets = {
    enable = true;
    mpdIntegration = {
      enableStats = true;
      enableUpdate = true;
      host = "rupert.roto.lol";
      port = 6600;
    };
    settings = {
      plugins = [
        # "listenbrainz"
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

      import = {
        write = true;
        copy = false;
      };
      include = [
        "/run/secrets/beets.yaml"
      ];
      types = {
        rating = "int";
      };
      importfeeds = {
        formats = [
          "m3u"
        ];
        dir = "/storage/music/root";
        relative_to = "/storage/music/root";
        m3u_name = "latest.m3u";
      };
      mpd = {
        host = "rupert.roto.lol";
        port = 6600;
        #password: "";
      };
      mpdstats = {
        host = "rupert.roto.lol";
        port = 6600;
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
