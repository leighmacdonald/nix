{ pkgs, ... }:
{

  programs.nvf.settings.vim = {
    extraPlugins = with pkgs.vimPlugins; {
      neogen = {
        package = neogen;
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<Leader>nf";
        action = ":lua require('neogen').generate()<CR>";
        desc = "Add annotation";
      }
    ];
  };
}
