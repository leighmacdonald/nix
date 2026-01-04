{username, ...}: {
  services = {
    openssh = {
      enable = true;
      generateHostKeys = false;
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
}
