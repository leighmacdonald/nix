{
  programs.nvf.settings.vim.utility.images.image-nvim = {
    enable = true;
    setupOpts = {
      backend = "kitty";
      integrations.markdown = {
        enable = true;
        clearInInsertMode = true;
      };
    };
  };
}
