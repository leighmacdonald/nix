{username, ...}: {
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
        "Downloads"
        {
          directory = ".gnupg";
          mode = "0700";
        }
        # ".local/share/direnv"
      ];
      # files = [
      #   ".screenrc"
      # ];
    };
  };
}
