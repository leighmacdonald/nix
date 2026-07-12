{ pkgs, ... }:
{

  programs.nvf.settings.vim = {
    extraPlugins = with pkgs.vimPlugins; {
      neogit = {
        package = neogit;
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>g";
        action = "<cmd>Neogit<CR>";
      }
      {
        mode = "n";
        key = "<leader>c";
        action = "<cmd>Neogit close<CR>";
      }
      {
        mode = "n";
        key = "<leader>gs";
        action = "<cmd>Neogit kind=split<CR>"; # Open Neogit in a split
      }
      {
        mode = "n";
        key = "<leader>gy";
        action = "<cmd>Neogit commit<CR>"; # Shortcut to commit
      }
      {
        mode = "n";
        key = "<leader>gd";
        action = "<cmd>Neogit diff<CR>"; # View diffs
      }
      {
        mode = "n";
        key = "<leader>gp";
        action = "<cmd>Neogit push<CR>"; # Push changes
      }
      {
        mode = "n";
        key = "<leader>gl";
        action = "<cmd>Neogit log<CR>"; # View commit log
      }
    ];
  };
}
