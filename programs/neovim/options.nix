{
  programs.nvf.settings.vim = {
    syntaxHighlighting = true;
    viAlias = true;
    vimAlias = true;
    undoFile.enable = true;
    enableLuaLoader = true;
    globals.mapleader = " ";
    spellcheck = {
      #enable = true;
      #programmingWordlist.enable = true;
      #vim-dirtytalk.enable = true;
    };
    # extraPlugins = with pkgs.vimPlugins; [
    #   lazy.stats
    # ];
    options = {
      tabstop = 4;
      shiftwidth = 4;
      splitright = true;
      #autoindent = true;
      #smartindent = true;
      expandtab = true;
    };

    clipboard = {
      enable = true;
      providers.wl-copy.enable = true;
    };
  };
}
