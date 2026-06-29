{ pkgs, ... }:
{

  programs.nvf.settings.vim = {
    extraPlugins = with pkgs.vimPlugins; {
      neotest = {
        package = neotest;
        setup = ''
          require("neotest").setup({
          -- Add configuration for neotest if needed
          })
        '';
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>nn";
        action = "<cmd>lua require('neotest').run.run()<CR>"; # Run nearest test
      }
      {
        mode = "n";
        key = "<leader>nf";
        action = "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>"; # Tests in current file
      }
      {
        mode = "n";
        key = "<leader>ns";
        action = "<cmd>lua require('neotest').summary.toggle()<CR>"; # Toggle test summary
      }
    ];
  };
}
