{pkgs, ...}: {
  programs.fish = {
    enable = false;

    interactiveShellInit = ''
      set fish_greeting # Disable greeting
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
