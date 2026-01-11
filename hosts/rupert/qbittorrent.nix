{ username, pkgs, ... }:
{
  services.qbittorrent = {
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
}
