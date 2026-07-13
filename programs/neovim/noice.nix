{pkgs, ...}: {
  programs.nvf.settings.vim.extraPlugins = with pkgs.vimPlugins; {
    noice-nvim = {
      package = noice-nvim;
      setup = ''
        require('noice').setup({
          cmdline = { enabled = true },
          lsp = {
            override = {
              ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
              ["vim.lsp.util.stylize_markdown"] = true,
              ["cmp.entry.get_documentation"] = true,
            },
          },
        })'';
    };
  };
}
