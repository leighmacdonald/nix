{

  programs.beets = {
    # (re) import files
    # beet import /storage/music/root/managed -a -wp -q
    enable = true;
    mpdIntegration = {
      enableStats = true;
      enableUpdate = true;
      host = "rupert.roto.lol";
      port = 6600;
    };
    settings = {
      threaded = true;
      languages = [ "en" ];
      detail = true;
      plugins = [
        # "listenbrainz"
        "badfiles"
        "chroma"
        "musicbrainz"
        "autobpm"
        "badfiles"
        "discogs"
        "embedart"
        "fetchart"
        "ftintitle"
        "thumbnails"
        "fish"
        "fromfilename"
        "importfeeds"
        #"lyrics"
        "mpdstats"
        "mpdupdate"
        "smartplaylist"
        "web"
        "unimported"
        "lastimport"
      ];
      directory = "/storage/music/root";
      import = {
        write = true;
        copy = false;
        resume = true;
      };
      lastfm = {
        user = "roto69";
      };
      chroma = {
        auto = true;
      };
      include = [
        "/run/secrets/beets.yaml"
      ];
      ftintitle = {
        auto = true;

      };
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
      web = {
        host = "rupert.roto.lol";
        port = 8337;
        include_paths = true;
        readonly = false;
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
          #"google"
          "genius"
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
