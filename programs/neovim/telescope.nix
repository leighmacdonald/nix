{ pkgs, ... }: {
  programs.nvf.settings.vim = {
    telescope = {
      enable = true;

      extensions = [
        {
          name = "fzf";
          packages = [ pkgs.vimPlugins.telescope-fzf-native-nvim ];
          setup = {
            fzf = {
              fuzzy = true;
            };
          };
        }
      ];
    };

    extraPlugins = with pkgs.vimPlugins; {
      telescope-ui = {
        package = telescope-ui-select-nvim;
      };

      telescope-fzf = {
        package = telescope-fzf-native-nvim;
      };

      telescope-git = {
        package = telescope-github-nvim;
      };

      telescope-frecency = {
        package = telescope-frecency-nvim;
      };

      telescope-undo = {
        package = telescope-undo-nvim;
      };

      telescope-live-grep = {
        package = telescope-live-grep-args-nvim;
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<CR>"; # Find files
      }
      {
        mode = "n";
        key = "<leader>tl";
        action = "<cmd>Telescope live_grep<CR>"; # Live grep
      }
      {
        mode = "n";
        key = "<leader>b";
        action = "<cmd>Telescope buffers<CR>"; # Buffers
      }
      {
        mode = "n";
        key = "<leader>h";
        action = "<cmd>Telescope help_tags<CR>"; # Help tags
      }
      {
        mode = "n";
        key = "<leader>tq";
        action = "<cmd>Telescope frecency<CR>"; # Frequent files
      }
      {
        mode = "n";
        key = "<leader>tu";
        action = "<cmd>Telescope undo<CR>"; # Undo history
      }
      {
        mode = "n";
        key = "<leader>tgc";
        action = "<cmd>Telescope git_commits<CR>"; # Git commits
      }
      {
        mode = "n";
        key = "<leader>tgs";
        action = "<cmd>Telescope git_status<CR>"; # Git status
      }
    ];
  };
}
