{
  programs.nvf.settings.vim = {
    autocomplete = {
      #enableSharedCmpSources = true;
      blink-cmp = {
        enable = true;
        setupOpts = {
          keymap.preset = "super-tab";
          cmdline.keymap.preset = "super-tab";
          signature.enabled = true;
        };
        sourcePlugins = {
          emoji.enable = true;
          ripgrep.enable = true;
        };
        friendly-snippets.enable = true;
      };
    };

  };
}
