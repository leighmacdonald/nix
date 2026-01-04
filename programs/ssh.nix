{
  programs.ssh = {
    #startAgent = true;
    matchBlocks = {
      "github" = {
        addKeysToAgent = "yes";
        identityFile = "~/.ssh/id_ed25519";
        user = "git";
        host = "github.com";
      };
      "local" = {
        addKeysToAgent = true;
        identityFile = "~/.ssh/id_ed25519";
        match = "192.168.0.*";
      };
      "uncletopia" = {
        addKeysToAgent = true;
        identityFile = "~/.ssh/id_rsa_legacy";
        match = "*.uncletopia.com";
        user = "tf2server";
      };
    };
  };
}
