{ username, ... }:
{
  services.ssh-agent = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.ssh = {
    extraConfig = "AddKeysToAgent yes";
    enableDefaultConfig = false;
    enable = true;
    matchBlocks = {
      "*" = {
        addKeysToAgent = "yes";
        controlMaster = "yes";
        compression = true;
        user = username;
        identityFile = "/run/secrets/id_ed25519";
      };
      "github" = {
        user = "git";
        host = "github.com";
        identityFile = "/run/secrets/id_ed25519";
      };
      "local" = {
        host = "192.168.0.*";
        user = username;
        compression = false;
        identityFile = "/run/secrets/id_ed25519";
      };
      "uncletopia" = {
        identityFile = "/run/secrets/id_rsa";
        host = "*.uncletopia.com";
        user = "tf2server";
      };
      "uncletopia_ts" = {
        identityFile = "/run/secrets/id_rsa";
        host = "100.69.69.*";
        user = "tf2server";
      };
    };
  };
}
