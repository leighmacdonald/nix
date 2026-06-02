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
    stateVersion = "26.05";

    packages = with pkgs; [
      which
    ];
  };

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    git = {
      enable = true;
      package = pkgs.gitMinimal;
      settings.user = {
        name = config.accounts.email.accounts.default.realName;
        email = config.accounts.email.accounts.default.address;
      };
    };
    home-manager.enable = true;
  };
}
