{pkgs, ...}: {
  programs.nvf.settings.vim = {
    startPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        pname = "opencode-nvim";
        version = "2026-07-12";
        src = pkgs.fetchFromGitHub {
          owner = "nickjvandyke";
          repo = "opencode.nvim";
          rev = "main";
          hash = "sha256-bYd5xpdY9ZAcsdQwqhn3oK1Rndi87hNwlB86XmSqVNo=";
        };
      })
    ];

    extraPlugins = {
      opencode-nvim = {
        setup = ''
          vim.g.opencode_opts = {		  }
          vim.o.autoread = true
        '';
      };
    };
    keymaps = [
      {
        key = "<leader>qa";
        mode = "n";
        action = '':lua function() require("opencode").ask("@this: ") end<CR>'';
        desc = "Ask OpenCode";
      }
      {
        key = "<leader>qs";
        mode = "n";
        action = ''lua: function() require("opencode").select() end<CR>'';
        desc = "Select OpenCode";
      }
      {
        mode = "n";
        key = "<leader>qc";
        action = ''lua: function() return require("opencode").operator("@this ") end<CR>'';
        desc = "Send range to OpenCode";
      }
    ];
  };
}
