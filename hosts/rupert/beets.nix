{

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
        "chroma"
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
      ];
      directory = "/storage/music/root";
      import = {
        write = true;
        copy = false;
      };
      chroma = {
        auto = true;
      };
      include = [
        "/run/secrets/beets.yaml"
      ];

      smartplaylist = {
        playlist_dir = "/storage/music/playlists";
        relative_to = "/storage/music/root";
        forward_slash = false;
        playlists = [
          {
            name = "ReleasedIn$year.m3u";
            query = "year";
          }
        ];
      };

      match = {
        strong_rec_thresh = 0.14;
      };
      quiet_fallback = "asis";
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
        force = true;
        print = false;
        sources = [
          "lrclib"
          "google"
          #"genius"
          #"tekstowo"
        ];
        synced = true;
      };
      # listenbrainz = {
      #   token = "TOKEN";
      #   username = "LISTENBRAINZ_USERNAME";
      # };
      loadext = [ "libicu" ];
      musicbrainz = {
        auto = true;
      };
      # discogs = {
      #   user_token = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
      # };
    };
  };

}
