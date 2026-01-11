{ pkgs, ... }:
{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      set fish_history saved
      starship init fish | source
    '';
    plugins = [
      {
        name = "git";
        src = pkgs.fishPlugins.plugin-git;
      }
      {
        name = "grc";
        src = pkgs.fishPlugins.grc;
      }
      {
        name = "colored-man-pages";
        src = pkgs.fishPlugins.colored-man-pages;
      }
    ];
  };
}
