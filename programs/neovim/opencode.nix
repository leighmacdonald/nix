{pkgs, ...}: {
  programs.nvf = {
    settings.vim.startPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        pname = "opencode-nvim";
        version = "2026-07-12"; # use the latest commit date or tag
        src = pkgs.fetchFromGitHub {
          owner = "nickjvandyke"; # or the appropriate fork/repo you are using
          repo = "opencode.nvim";
          rev = "main"; # or a specific release tag
          hash = "sha256-bYd5xpdY9ZAcsdQwqhn3oK1Rndi87hNwlB86XmSqVNo=";
        };
      })
    ];
  };
}
