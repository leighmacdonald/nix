{
  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
    config = {
      global = {
        ignore_paths = "/projects/worktrees";
      };
    };
    nix-direnv = {
      enable = true;
    };
  };
}
