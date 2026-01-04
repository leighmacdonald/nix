{ username, hostName, ... }:
{
  networking = {
    firewall = {
      allowedTCPPorts = [ 22 ];
    };
  };

  services = {
    openssh = {
      enable = true;
      generateHostKeys = false;

      # extraConfig = ''
      #   HostKeyAlgorithms ssh-ed25519-cert-v01@openssh.com,ssh-ed25519
      #   MACs hmac-sha2-512-etm@openssh.com
      #   HostbasedAcceptedKeyTypes ecdsa-sha2-nistp256,ecdsa-sha2-nistp384,ecdsa-sha2-nistp521,ssh-ed25519
      # '';
      hostKeys = [
        {
          comment = "deployed key ec";
          type = "ed25519";
          path = "/run/secrets/hostkey_${hostName}_ed25519";
        }
        {
          comment = "deployed key rsa";
          type = "rsa";
          path = "/run/secrets/hostkey_${hostName}_rsa";
        }
      ];
      settings = {
        StrictModes = true;
        PasswordAuthentication = false;
        # FIXME Needed for nixos-anywhere?
        PermitRootLogin = "yes";
        AllowUsers = [ username ];
        # KexAlgorithms = [ "curve25519-sha256" ];
        # Ciphers = [
        #   "chacha20-poly1305@openssh.com"
        #   "aes256-gcm@openssh.com"
        # ];
      };
    };
  };
}
