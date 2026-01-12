{
  programs.kitty = {
    enable = true;
    enableGitIntegration = true;
    mouseBindings = {
      "ctrl+left click" = "ungrabbed mouse_handle_click selection link prompt";
      "left click" = "ungrabbed no-op";
    };
    shellIntegration = {
      enableFishIntegration = true;
    };
  };
}
