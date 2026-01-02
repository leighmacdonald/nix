{
  programs.uwsm = {
    enable = true;

    waylandCompositors = {
      hyprland = {
        prettyName = "Hyprland";
        comment = "Hyprland managed by UWSM";
        binPath = "/etc/profiles/per-user/leigh/bin/start-hyprland";
      };
    };
  };
}
