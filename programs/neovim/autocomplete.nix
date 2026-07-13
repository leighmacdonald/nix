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
          # sources = {
          #   #-- Either enable LSP (and optionally buffer) source globally
          #   default = [
          #     "lsp"
          #     "buffer"
          #   ];
          #   #-- Or only for Ask
          #   per_filetype = {
          #     opencode_ask = [
          #       "lsp"
          #       "buffer"
          #     ];
          #   };
          #   #-- Display buffer completions (if included above) when no LSP completions are available
          #   providers = {
          #     lsp = {
          #       fallbacks = { };
          #     };
          #   };
          # };
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
