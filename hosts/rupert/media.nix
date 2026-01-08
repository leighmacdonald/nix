{
  pkgs,
  username,
  ...
}:
{
  services = {
    qbittorrent = {
      enable = true;
      extraArgs = [ "--confirm-legal-notice" ];
      package = pkgs.qbittorrent-nox;
      openFirewall = true;
      torrentingPort = 30000;
      webuiPort = 8080;
      user = username;
      group = "lusers";
      profileDir = "/backup/config/qbittorrent";
      serverConfig = {
        LegalNotice.Accepted = true;
        Application = {
          FileLogger = {
            Age = 1;
            AgeType = 1;
            Backup = true;
            DeleteOld = true;
            Enabled = true;
            MaxSizeBytes = 66560;
            Path = "/backup/config/qbittorrent/qBittorrent/data/logs";
          };
        };
        BitTorrent = {
          Session = {
            AddTorrentStopped = false;
            BTProtocol = "TCP";
            DefaultSavePath = "/storage/downloads/complete";
            Encryption = 1;
            LSDEnabled = false;
            MaxActiveDownloads = 4;
            MaxActiveTorrents = 10000;
            MaxActiveUploads = 1000;
            MaxUploads = -1;
            MaxUploadsPerTorrent = -1;
            PeXEnabled = false;
            PerformanceWarning = true;
            Port = 30000;
            QueueingSystemEnabled = true;
            SSL.Port = 64129;
            ShareLimitAction = "Stop";
            TempPath = "/storage/downloads/incomplete";
            TempPathEnabled = true;
            TorrentExportDirectory = "/storage/downloads/torrents";
          };
        };
        Core = {
          TorrentExportDirectory = "/storage/downloads/torrents";
        };
        Meta = {
          MigrationVersion = 8;
        };
        Network = {
          PortForwardingEnabled = false;
          Proxy = {
            HostnameLookupEnabled = false;
            Profiles = {
              BitTorrent = true;
              Misc = true;
              RSS = true;
            };
          };
        };
        Preferences = {
          WebUI = {
            Username = "roto";
            Password_PBKDF2 = "5wlKWyoV8/hHtV5lxfS67g==:KZjO5AjsXJ78X1jRozwjlJ40b1pUSCpzViFIjzElCmF9LEvkcOVQuGxTjGhZY8pUz1UUJQiVJH2vEZMnRQNpbw==";
          };
          General.Locale = "en";
        };
        Rss.AutoDownloader.DownloadRepacks = false;
      };
    };

    prowlarr = {
      enable = true;
      openFirewall = true;
      dataDir = "/backup/config/prowlarr/data";
      settings = {
        server.port = 9696;
        log.analyticsEnabled = false;
      };
    };

    lidarr = {
      enable = true;
      openFirewall = true;
      dataDir = "/backup/config/lidarr";
      user = username;
      group = "lusers";
      settings = {
        log.analyticsEnabled = false;
        server.port = 8686;
      };
    };

    sonarr = {
      enable = true;
      openFirewall = true;
      dataDir = "/backup/config/sonarr";
      user = username;
      group = "lusers";
      settings = {
        log.analyticsEnabled = false;
        server.port = 8989;
      };
    };

    radarr = {
      enable = true;
      openFirewall = true;
      dataDir = "/backup/config/radarr";
      user = username;
      group = "lusers";
      settings = {
        log.analyticsEnabled = false;
        server.port = 7878;
      };
    };

    bazarr = {
      enable = true;
      openFirewall = true;
      dataDir = "/backup/config/bazarr";
      user = username;
      listenPort = 6767;
      group = "lusers";
    };

    jellyseerr = {
      enable = true;
      openFirewall = true;
      #configDir = "/backup/jellyseerr";
      port = 5055;
    };

    jellyfin = {
      enable = true;
      openFirewall = true;
      user = username;
      group = "lusers";
      cacheDir = "/backup/config/jellyfin/cache";
      dataDir = "/backup/config/jellyfin";
      #port = 8096;
    };

    tautulli = {
      enable = true;
      openFirewall = true;
      dataDir = "/backup/config/tautulli";
      user = username;
      group = "lusers";
      port = 8181;
    };
  };
}
