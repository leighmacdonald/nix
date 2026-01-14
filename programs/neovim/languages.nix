{
  # home.packages = with pkgs; [

  # ];
  programs.nvf.settings.vim = {
    languages = {
      enableDAP = true;
      enableExtraDiagnostics = true;
      enableFormat = true;
      enableTreesitter = true;
      bash = {
        enable = true;
      };
      clang = {
        enable = true;
      };
      csharp = {
        enable = true;
      };
      css = {
        enable = true;
      };
      go = {
        enable = true;
        format = {
          type = [ "gofumpt" ];
        };
      };
      html = {
        enable = true;
      };
      json = {
        enable = true;
      };
      lua = {
        enable = true;
        lsp.lazydev.enable = true;
      };
      markdown = {
        enable = true;
        lsp.servers = [ "marksman" ];
        format.type = [ "prettierd" ];
        extensions.markview-nvim.enable = true;
      };
      nix = {
        enable = true;
        lsp.servers = [ "nixd" ];
        format.type = [ "alejandra" ];
      };
      python = {
        enable = true;
        dap.debugger = "debugpy";
        format.type = [ "black" ];
        lsp.servers = [ "basedpyright" ];
      };
      sql = {
        enable = true;
        dialect = "postgres";
        extraDiagnostics.types = [ "sqlfluff" ];
        format.type = [ "sqlfluff" ];
      };
      rust = {
        enable = true;
        dap = {
          adapter = "codelldb";
        };
        format.type = [ "rustfmt" ];
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
        format = {
          type = [ "prettierd" ];
        };
        extensions = {
          ts-error-translator.enable = true;
        };
        lsp.servers = [
          "ts_ls"
        ];
      };
      yaml = {
        enable = true;
        lsp.servers = [ "yaml-language-server" ];
      };
    };
  };
}
