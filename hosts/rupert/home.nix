{
  pkgs,
  username,
  ...
}: {
  imports = [
    ./beets.nix

    ../../env/email.nix
    ../../programs/btop.nix
    ../../programs/direnv.nix
    ../../programs/git.nix
    ../../programs/home-manager.nix
    ../../programs/home-ssh.nix
  ];
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "26.05"; # Please read the comment before changing.
    packages = with pkgs; [
      sops
      ssh-to-age
      age
      zellij
      intel-gpu-tools
    ];
    sessionVariables = {
      EDITOR = "nano";
      SUDO_EDITOR = "nano";
      SOPS_AGE_KEY_FILE = "/etc/sops/age/keys.txt";
    };
    sessionPath = [
      "$HOME/.nix-profile/bin"
      "/nix/var/nix/profiles/default/bin"
    ];
  };
}
