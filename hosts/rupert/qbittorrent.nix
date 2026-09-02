{ username, pkgs, ... }:

let
  copyMusic = pkgs.writeShellApplication {
    name = "copy-music-qbt.sh";
    text = ''
      DEST_ROOT="/storage/music/managed"
      CONTENT_PATH="''${1:?missing content path}"
      NAME="''${2:?missing torrent name}"
      CATEGORY="''${3:-}"

      if [[ "$CATEGORY" != "lidarr" ]]; then
        echo "copy-music-qbt: skipping ''${NAME} (category: ''${CATEGORY})"
        exit 0
      fi

      src="''${CONTENT_PATH%/}"
      if [[ ! -e "$src" ]]; then
        echo "copy-music-qbt: source not found: ''${src}" >&2
        exit 1
      fi

      dest="$DEST_ROOT/$(basename "$src")"
      if [[ -e "$dest" ]]; then
        echo "copy-music-qbt: skipping ''${NAME} (already present: ''${dest})"
        exit 0
      fi

      mkdir -p "$DEST_ROOT"
      echo "copy-music-qbt: copying ''${NAME} -> ''${dest}"
      cp -a "$src" "$dest"
      echo "copy-music-qbt: done"
    '';
  };
in
{
  environment.systemPackages = [ copyMusic ];

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
      AutoRun = {
        enabled = true;
        program = "${copyMusic}/bin/copy-music-qbt.sh %F %N %L";
      };
    };
  };
}
