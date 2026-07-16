{
  programs.rofi = {
    enable = true;
    #            font = "JetBrainsMono Nerd Font 18";
    modes = [
      "drun"
      "window"
      "run"
    ];
    extraConfig = {
      run-command = "uwsm app -- {cmd}";
    };
  };
}
