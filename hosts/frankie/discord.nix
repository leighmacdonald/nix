{ inputs, username, ... }: {
  imports = [ inputs.nixcord.nixosModules.nixcord ];

  programs.nixcord = {
    enable = true;
    user = username;
    discord.vencord.enable = true; # Standard Vencord
    vesktop.enable = true;
    config = {
      frameless = true;
      plugins = {
        hideMedia.enable = true;
        ignoreActivities = {
          enable = true;
          ignorePlaying = true;
        };
      };
    };
  };
}
