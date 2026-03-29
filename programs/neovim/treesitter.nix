{ pkgs, ... }:
{

  programs.nvf.settings.vim = {
    lsp.servers = {
      buf_ls = {
        filetypes = [ "proto" ];
        root_markers = [ "buf.yaml" ];
        cmd = [
          "buf"
          "lsp"
          "serve"
        ];
        enable = true;
      };
    };
    treesitter = {
      enable = true;
      grammars = pkgs.vimPlugins.nvim-treesitter.allGrammars;
      # grammars = with pkgs.vimPlugins.nvim-treesitter.withPlugins; [
      #   regex
      #   kdl
      #   bash
      #   c
      #   cpp
      #   c-sharp
      #   haskell
      #   html
      #   json
      #   markdown_inline
      #   printf
      #   proto
      #   sourcepawn
      #   typescript
      #   tsx
      #   vim
      #   vimdoc
      #   xml
      #   yaml
      #   gotmpl
      #   go
      #   gosum
      #   sql
      #   rust
      #   typescript
      #   tsx
      #   python
      #   fish
      # ];
      indent.enable = true;
      #fold.enable = false;
      #incrementalSelection.enable = true;
      highlight = {
        enable = true;
        #indent.enable = true;
        #fold.enable = false;
        #incrementalSelection.enable = true;
        #additionalVimRegexHighlighting = true;
        # disable = ```lua
        # -- Disable slow treesitter highlight for large files
        # function(lang, buf)
        #   local max_filesize = 1000 * 1024 -- 1MB
        #   local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
        #   if ok and stats and stats.size > max_filesize then
        #       return true
        #   end
        # end
        # ```;
      };
      textobjects.enable = true;
      context = {
        enable = true;
      };
    };
  };
}
