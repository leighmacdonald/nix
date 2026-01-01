{
  inputs,
  ...
}:
{
  imports = [
    inputs.nvf.homeManagerModules.default
  ];

  programs.nvf = {
    enable = true;
    enableLuaLoader = true;
    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;
        lsp = {
          enable = true;
        };
        autocomplete = {
          enableSharedCmpSources = true;
        };
        clipboard = {
          enable = true;
          wl-copy.enable = true;
        };
        diagnostics = {
          enable = true;
        };

      };
    };
  };
}
