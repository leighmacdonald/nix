{
  inputs,
  username,
  ...
}:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    validateSopsFiles = false;
    defaultSopsFile = "/home/${username}/nix/secrets/secrets.yaml";
    defaultSopsFormat = "yaml";
    age = {
      keyFile = "/home/${username}/.config/sops/age/keys.txt";
    };

    secrets = {
      password = {
        neededForUsers = true;
      };
      smb_secrets = {
        path = "/etc/nixos/smb-secrets";
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
