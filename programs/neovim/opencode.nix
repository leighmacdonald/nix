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
        key = "<leader>oa";
        mode = "nx";
        action = ''function() require("opencode").ask("@this: ") end'';
        desc = "Ask OpenCode";
      }
      {
        key = "<leader>os";
        mode = "nx";
        action = ''function() require("opencode").select() end'';
        desc = "Select OpenCode";
      }
      {
        mode = "n";
        key = "<S-C-o>";
        action = ''function() return require("opencode").operator("@this ") end'';
        desc = "Send range to OpenCode";
        expr = true;
      }
    ];
  };
}
