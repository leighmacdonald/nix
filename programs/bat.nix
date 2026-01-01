{ pkgs, ... }:
{
  programs.bat = {
    themes = {
      catppuccin = {
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat"; # Bat uses sublime syntax for its themes
          rev = "26c57ec282abcaa76e57e055f38432bd827ac34e";
          sha256 = "6810349b28055dce54076712fc05fc68da4b8ec0";
        };
        file = "Dracula.tmTheme";
      };
    };
  };
}
