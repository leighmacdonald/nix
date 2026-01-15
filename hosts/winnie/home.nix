{
  config,
  pkgs,
  username,
  ...
}:

{
  imports = [
    ../../env/email.nix
  ];
  home = {
    #uid = 2000;
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.11";

    packages = with pkgs; [
      which
    ];
  };

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      #waylandSupport = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    git = {
      enable = true;
      settings.user = {
        name = config.accounts.email.accounts.default.realName;
        email = config.accounts.email.accounts.default.address;
      };
    };
    home-manager.enable = true;
  };
}
