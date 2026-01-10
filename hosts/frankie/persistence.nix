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
  fileSystems."/var/log".neededForBoot = true;
  fileSystems."/etc/sops".neededForBoot = true;

  environment.persistence."/persist" = {
    enable = true;
    hideMounts = false;
    directories = [
      "/var/log"
      {
        directory = "/home/${username}/.ssh";
        user = username;
        group = "lusers";
        mode = "0700";
      }
    ];
    files = [
      "/etc/machine-id"
      #"/etc/sops/age/keys.txt"
      # Handled with sops
      # "/etc/ssh/ssh_host_ed25519_key"
      # "/etc/ssh/ssh_host_ed25519_key.pub"
    ];
    users.${username} = {
      directories = [
        ".mozilla"
        ".config/vesktop"
        ".config/mpd"
        ".cache/keepassxc"
        ".cache/mozilla"
        # Projects and stuff?
        ".local/share/zed"
        "Downloads"
        {
          directory = ".gnupg";
          mode = "0700";
        }
        ".local/share/direnv"
      ];
      files = [
        # Select exteral DAC by default
        ".local/state/wireplumber/default-nodes"
        # Configure / Disable io
        ".local/state/wireplumber/default-profile"
        ".local/share/fish/fish_history"
      ];
    };
  };
}
