{
  programs.gh.enable = true;
  programs.lazygit.enable = true;
  programs.git = {
    enable = true;
    settings = {
      gpg = {
        format = "ssh";
      };
      commit = {
        gpgsign = true;
      };
      rerere = {
        enabled = true;
      };
      diff = {
        algorithm = "histogram";
        submodule = "log";
      };
      core = {
        pager = "delta";
        autocrlf = false;
      };
      fetch = {
        prune = true;
      };
      init = {
        defaultBranch = "master";
      };
      push = {
        autoSetupRemote = true;
        followtags = true;
      };
      rebase = {
        updateRefs = true;
      };
      merge = {
        conflictstyle = "zdiff3";
      };
      status = {
        submoduleSummary = true;
      };
      submodule = {
        recurse = true;
      };
      user = {
        name = "Leigh MacDonald";
        email = "leigh.macdonald@gmail.com";
        signingkey = "~/.ssh/id_rsa.pub";
      };
    };
    ignores = [
      "*~"
      "*.swp"
      ".DS_Store"
    ];
  };
}
