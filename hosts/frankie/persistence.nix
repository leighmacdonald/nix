{ username, inputs, ... }:
{
  imports = [ inputs.impermanence.nixosModules.impermanence ];
  fileSystems = {

    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = [
        "defaults"
        "size=10%"
        "mode=755"
      ];
    };
    "/persist".neededForBoot = true;
    "/nix".neededForBoot = true;
    "/etc/sops".neededForBoot = true;
  };

  environment.persistence."/persist" = {
    enable = true;
    hideMounts = false;
    directories = [
      "/var/lib/nixos"
      "/var/lib/docker"
      "/var/log"
      #Permissions incorrect otherwise.
      {
        directory = "/home/${username}/.ssh";
        user = username;
        group = "lusers";
        mode = "0700";
      }
    ];
    files = [
      "/etc/machine-id"
      "/var/lib/tailscale/tailscaled.state"
    ];
    users.${username} = {
      directories = [
        ".mozilla"
        ".config/vesktop"
        ".config/mpd"
        ".cache/keepassxc"
        ".cache/mozilla"
        ".cache/go-build"
        ".cache/nix"
        ".cache/pnpm"
        ".cache/fish"
        ".cache/rpmc"
        ".sm-pkg"
        ".steam"
        ".rustup"
        ".local/share/zed"
        ".local/share/Steam"
        ".local/share/mpd"
        ".local/share/fish"
        "go"
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
        ".config/wireplumber/default-nodes"
        # Configure / Disable io
        #".local/share/fish/alt_history"
        ".ssh/authorized_keys"
        ".ssh/known_hosts"
      ];
    };
  };
}
