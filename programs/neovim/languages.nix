{
  programs.nvf.settings.vim = {
    languages = {
      enableDAP = true;
      enableExtraDiagnostics = true;
      enableFormat = true;
      enableTreesitter = true;

      clang = {
        enable = true;
        treesitter.enable = true;
      };
      csharp = {
        enable = true;
        treesitter.enable = true;
        lsp.enable = true;
      };
      css = {
        enable = true;
        format.enable = true;
        treesitter.enable = true;
        lsp.enable = true;
      };
      go = {
        enable = true;
        dap = {
          enable = true;
        };
        format = {
          enable = true;
          type = [ "gofumpt" ];
        };
        lsp = {
          enable = true;
        };
        treesitter.enable = true;
      };
      html = {
        enable = true;
        extraDiagnostics.enable = true;
        format.enable = true;
      };
      json = {
        enable = true;
        format.enable = true;
      };

      lua = {
        lsp.lazydev.enable = true;
        extraDiagnostics.enable = true;
        lsp.enable = true;
      };

      markdown = {
        enable = true;
        extraDiagnostics.enable = true;
        format.enable = true;
        lsp.enable = true;
        treesitter.enable = true;
        extensions.markview-nvim.enable = true;
      };

      nix = {
        enable = true;
        extraDiagnostics = {
          enable = true;
        };
        format.enable = true;
        treesitter.enable = true;
      };

      sql = {
        enable = false;
        format.enable = false;
        treesitter.enable = true;
        #extraDiagnostics.enable = true;
        dialect = "postgresql";
        lsp.enable = true;
      };

      rust = {
        enable = true;
        format.enable = true;
        treesitter.enable = true;
        lsp.enable = true;
        dap = {
          enable = true;
        };
        extensions.crates-nvim = {
          enable = true;
          setupOpts = {
            completion.crates.enabled = true;
            lsp = {
              enabled = true;
              actions = true;
              completion = true;
              hover = true;
            };
          };

        };

      };

      ts = {
        enable = true;
        extraDiagnostics.enable = true;
        format = {
          enable = true;
          type = [ "prettierd" ];
        };
        lsp = {
          enable = true;
        };
        treesitter.enable = true;
      };
      yaml = {
        enable = true;
        lsp.enable = true;
        treesitter.enable = true;
      };
    };
  };
}
