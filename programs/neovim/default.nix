{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.nvf.homeManagerModules.default
    ./autocomplete.nix
    ./comments.nix
    ./images.nix
    ./keys.nix
    ./languages.nix
    ./lsp.nix
    ./mini.nix
    ./snacks.nix
    ./tabline.nix
    ./treesitter.nix
    ./which-key.nix
  ];

  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        syntaxHighlighting = true;

        # extraPlugins = with pkgs.vimPlugins; [
        #   lazy.stats
        # ];
        options = {
          tabstop = 4;
          shiftwidth = 4;
          splitright = true;
        };

        spellcheck = {
          #enable = true;
          #programmingWordlist.enable = true;
          #vim-dirtytalk.enable = true;
        };
        undoFile.enable = true;
        # projects = {
        #   projects-nvim = {
        #     enable = true;
        #   };
        # };

        visuals = {
          nvim-cursorline.enable = true;
          nvim-web-devicons.enable = true;
        };
        utility = {
          direnv.enable = true;
          icon-picker.enable = true;
          surround.enable = true;
        };

        extraPackages = [
          pkgs.fzf
          pkgs.ripgrep
        ];
        fzf-lua = {
          enable = true;
        };
        formatter = {
          conform-nvim = {
            enable = true;
          };
        };
        debugger = {
          nvim-dap = {
            enable = true;
            ui = {
              enable = true;
            };
          };
        };
        telescope.enable = true;
        enableLuaLoader = true;
        # extraPlugins = with pkgs.vimPlugins; [
        #   snacks-nvim
        # ];
        viAlias = true;
        vimAlias = true;

        clipboard = {
          enable = true;
          providers.wl-copy.enable = true;
        };
        diagnostics = {
          enable = true;
          nvim-lint = {
            enable = true;
          };
        };
        statusline = {
          lualine.enable = true;
        };
      };
    };
  };
}
