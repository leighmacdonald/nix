{
  pkgs,
  username,
  ...
}:
{
  imports = [
    ../../env/email.nix
    ../../programs/btop.nix
    ../../programs/direnv.nix
    ../../programs/git.nix
    ../../programs/home-manager.nix
    ../../programs/neovim
    ../../programs/home-ssh.nix
  ];
  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.11"; # Please read the comment before changing.
    packages = with pkgs; [
      sops
      ssh-to-age
      age
    ];
    sessionVariables = {
      EDITOR = "nvim";
      SUDO_EDITOR = "nvim";
      MANPAGER = "nvim +Man!";
      MOZ_USE_XINPUT2 = "1"; # smooth scroll
      NIXOS_OZONE_WL = "1";
      SOPS_AGE_KEY_FILE = "/etc/sops/age/keys.txt";
    };
    sessionPath = [
      "$HOME/.nix-profile/bin"
      "/nix/var/nix/profiles/default/bin"
    ];
  };
}
