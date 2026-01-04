{ pkgs, ... }:
{

  programs.nvf.settings.vim = {
    extraPlugins = with pkgs.vimPlugins; {
      neogen = {
        package = neogen;
      };
    };

    maps.normal = {
      "<Leader>nf" = {
        action = ":lua require('neogen').generate()<CR>";
        desc = "Add annotation";
      };
    };
  };
}
