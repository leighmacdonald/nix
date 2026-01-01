{ pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    package = pkgs.ghostty;
    settings = {
      window-theme = "dark";
      window-decoration = false;
      window-padding-x = 5;
      window-padding-y = 5;
      confirm-close-surface = false;
      initial-window = false;
      shell-integration-features = "cursor,sudo,title,ssh-env,ssh-terminfo,path";
      linux-cgroup = "always";
      linux-cgroup-hard-fail = true;
      clipboard-read = "allow";
      clipboard-write = "allow";
      adjust-cell-width = "-7%";
      working-directory = "home";
      background-blur = true;
      #font-family = "\"JetBrainsMono Nerd Font\"";
    };
  };
}
