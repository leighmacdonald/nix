{
  inputs,
  ...
}:
{
  imports = [
    inputs.nvf.homeManagerModules.default
    ./autocomplete.nix
    ./autopairs.nix
    ./bufferline.nix
    ./comments.nix
    ./cursorline.nix
    ./dashboard.nix
    ./debugger.nix
    ./diagnostics.nix
    ./direnv.nix
    ./formatter.nix
    ./gitsigns.nix
    ./icon-picker.nix
    ./images.nix
    #./keys.nix
    ./languages.nix
    ./lsp.nix
    ./mini.nix
    ./neogen.nix
    ./neogit.nix
    ./neotest.nix
    ./neotree.nix
    ./noice.nix
    ./notify.nix
    ./nvim-surround.nix
    ./options.nix
    ./plenary.nix
    ./projects.nix
    #./snacks.nix
    ./statusline.nix
    ./surround.nix
    ./tabline.nix
    ./telescope.nix
    ./todo.nix
    ./treesitter.nix
    ./trouble.nix
    ./web-devicons.nix
    ./which-key.nix
  ];

  programs.nvf = {
    enable = true;
    enableManpages = true;
  };
}
