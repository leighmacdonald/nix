{ pkgs, ... }:
{
  programs.nvf.settings.vim = {
    extraPackages = [
      pkgs.tree-sitter
      pkgs.nodejs
      pkgs.gcc
    ];
    treesitter = {
      enable = true;
      grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        regex
        kdl
        bash
        c
        cpp
        c-sharp
        haskell
        html
        json
        jsonc
        markdown_inline
        printf
        typescript
        tsx
        vim
        vimdoc
        xml
        yaml
      ];
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
