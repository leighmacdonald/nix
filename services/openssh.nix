{username, ...}: {
  services = {
    openssh = {
      enable = true;
      #generateHostKeys = false;
      openFirewall = true;
      # Define this so that we don't setup RSA keys at all.
      hostKeys = [
        {
          comment = "host key";
          path = "/etc/ssh/ssh_host_ed25519_key";
          type = "ed25519";
        }
      ];
      settings = {
        StrictModes = true;
        PasswordAuthentication = false;
        PermitRootLogin = "no";
        PrintMotd = true;
        AllowUsers = [username];
      };
    };
  };
  programs.ssh = {
    knownHosts = {
      frankie = {
        hostNames = ["192.168.0.200" "frankie.roto.lol"];
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPOROI6UBd3pC0BVQox3q/XFboITZS6hrsrZwcTbXUD2";
      };
      rupert = {
        hostNames = ["192.168.0.201" "rupert.roto.lol"];
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID8hr1jEi+Gr+tPiYg3K3bmR4cSdMeCHsPR44/wx3dZ2";
      };
      # pi2
      mika = {
        hostNames = ["192.168.0.210" "mika.roto.lol"];
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILg6SFnHj0MgLOKoMXbdPXjdFvavnHPm9tJoiEhKNKNa";
      };
      # bedroom pi4
      phyllis = {
        hostNames = ["192.168.0.211" "phyllis.roto.lol"];
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPOROI6UBd3pC0BVQox3q/XFboITZS6hrsrZwcTbXUD2";
      };
      # util pi4
      winnie = {
        hostNames = ["192.168.0.212" "winnie.roto.lol"];
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEe1Rvn9QZIwoGryUNY285k3+z/6InEzl/0OGsA/RwUP";
      };
    };
  };
}
