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
    defaultSopsFile = "/home/${username}/nix/secrets/secrets.yaml";
    defaultSopsFormat = "yaml";
    age = {
      keyFile = "/home/${username}/.config/sops/age/keys.txt";
    };

    secrets = {
      password = {
        neededForUsers = true;
      };
      lastfm = {
        mode = "0600";
        owner = username;
      };
      tskey = { };
      smb_secrets = {
        path = "/etc/nixos/smb-secrets";
      };
      "hostkey_${hostName}_ed25519" = {
        path = "/etc/ssh/ssh_host_ed25519_key";
        mode = "0600";
        owner = "root";
      };
      id_rsa = {
        path = "/home/${username}/.ssh/id_rsa";
        mode = "0600";
        owner = username;
      };
      id_rsa_stv = {
        path = "/home/${username}/.ssh/id_stv";
        mode = "0600";
        owner = username;
      };
      id_ut = {
        path = "/home/${username}/.ssh/id_ut";
        mode = "0600";
        owner = username;
      };
    };
  };
}
