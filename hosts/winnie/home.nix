{
  config,
  pkgs,
  username,
  ...
}:

{
  imports = [
    ../../accounts/email.nix
  ];
  # link all files in `./scripts` to `~/.config/i3/scripts`
  home = {
    #uid = 2000;
    username = username;
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
    starship = {
      enable = false;
    };
  };
}
