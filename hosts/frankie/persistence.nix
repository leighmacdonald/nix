{ username, ... }:
{
  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [
      "defaults"
      "size=25%"
      "mode=755"
    ];
  };

  fileSystems."/persist".neededForBoot = true;
  fileSystems."/nix".neededForBoot = true;
  fileSystems."/etc/sops".neededForBoot = true;

  environment.persistence."/persist" = {
    enable = true;
    hideMounts = false;
    directories = [
      "/var/lib/nixos"
      "/var/lib/docker"
      "/var/log"
      # Permissions incorrect otherwise.
      {
        directory = "/home/${username}/.ssh";
        user = username;
        group = "lusers";
        mode = "0700";
      }
    ];
    files = [
      "/etc/machine-id"
    ];
    users.${username} = {
      directories = [
        ".mozilla"
        ".config/vesktop"
        ".config/mpd"
        ".cache/keepassxc"
        ".cache/mozilla"
        ".steam"
        # Projects and stuff?
        ".local/share/zed"
        ".local/share/Steam"
        ".local/share/mpd"
        ".local/share/fish"
        "Downloads"
        {
          directory = ".gnupg";
          mode = "0700";
        }
        ".local/share/direnv"
        ".local/state/wireplumber"
      ];
      files = [
        #.local/share/listenbrainz-mpd/submission-cache.sqlite3
        # Select exteral DAC by default
        ".config/e/wireplumber/default-nodes"
        # Configure / Disable io
        #".local/share/fish/alt_history"
      ];
    };
  };
}
