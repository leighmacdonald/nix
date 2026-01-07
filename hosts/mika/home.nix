{
  config,
  username,
  ...
}:

{
  imports = [
    ../../accounts/email.nix
  ];
  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.11";
  };

  programs = {
    neovim = {
      enable = false;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      #waylandSupport = true;
    };

    direnv = {
      enable = false;
      nix-direnv.enable = false;
    };
    git = {
      enable = false;
      settings.user = {
        name = config.accounts.email.accounts.default.realName;
        email = config.accounts.email.accounts.default.address;
      };
    };
    home-manager.enable = true;
  };
}
