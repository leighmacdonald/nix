{username, ...}: {
  programs.nixcord = {
    enable = true;
    user = username;
    discord.vencord.enable = true; # Standard Vencord
    vesktop.enable = true;
    config = {
      frameless = true;
      transparent = true;
      useQuickCss = false;
      uiElements = {};

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
