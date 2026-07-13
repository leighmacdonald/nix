{
  programs.nvf.settings.vim = {
    lsp = {
      enable = true;
      formatOnSave = true;
      #lspkind.enable = true;
      lightbulb.enable = false;
      lspsaga.enable = true;
      trouble.enable = true;
      #lspSignature.enable = true;
      lspconfig.enable = true;
      nvim-docs-view.enable = true;
      null-ls.enable = true;
      otter-nvim = {
        enable = true;
        setupOpts.handle_leading_whitespace = false;
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>pd";
        action = "<cmd>lua vim.lsp.buf.definition()<CR>";
      }
      {
        mode = "n";
        key = "<leader>pr";
        action = "<cmd>lua vim.lsp.buf.references()<CR>";
      }
      {
        mode = "n";
        key = "<leader>ph";
        action = "<cmd>lua vim.lsp.buf.hover()<CR>";
      }
      {
        mode = "n";
        key = "<leader>pf";
        action = "<cmd>lua vim.lsp.buf.formatting()<CR>";
      }
    ];
  };
}
