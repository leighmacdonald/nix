{
  programs.rofi = {
    enable = true;
    #            font = "JetBrainsMono Nerd Font 18";
    modes = [ "drun" ];
    extraConfig = {
      run-command = "uwsm app -- {cmd}";
    };
  };
}
