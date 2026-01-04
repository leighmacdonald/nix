{pkgs, ...}: {
  programs.nvf.settings.vim = {
    extraPlugins = with pkgs.vimPlugins; {
      neotree = {
        package = neo-tree-nvim;
        setup = ''
          require("neo-tree").setup({
            close_if_last_window = true,
            clipboard = {},
            sync = "global",
          })
        '';
      };
    };

    maps.normal = {
      "<leader>z".action = "<cmd>Neotree<CR>";
      "<leader>x".action = "<cmd>Neotree close<CR>";
    };
  };
}
