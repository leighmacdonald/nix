{
  inputs,
  username,
  hostName,
  ...
}:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    validateSopsFiles = true;
    defaultSopsFile = ../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age = {
      #sshKeyPaths = ["/home/${username}/.ssh/id_ed25519"];
      keyFile = "/etc/sops/age/keys.txt";
      generateKey = false;

    };

    secrets = {
      keepass_main = {
        path = "/home/${username}/.keepass.key";
        format = "binary";
        mode = "0600";
        owner = username;
        sopsFile = ../secrets/secrets.key;
      };

      password = {
        neededForUsers = true;
      };
      lastfm = {
        mode = "0600";
        owner = username;
      };

      tskey = { };
      "hostkey_${hostName}_ed25519" = {
        mode = "0600";
        owner = "root";
      };
      id_ed25519 = {
        mode = "0600";
        owner = username;
      };
      "id_ed25519.pub" = {
        mode = "0600";
        owner = username;
      };
      id_rsa = {
        mode = "0600";
        owner = username;
      };
      "id_rsa.pub" = {
        mode = "0600";
        owner = username;
      };
      id_rsa_stv = {
        mode = "0600";
        owner = username;
      };
      id_ut = {
        mode = "0600";
        owner = username;
      };
    };
  };
}
