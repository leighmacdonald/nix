{
  pkgs,
  ...
}: {
  environment = {
    pathsToLink = [
      "/share/applications"
      "/share/xdg-desktop-portal"
    ];
    systemPackages = with pkgs; [
      killall
      wget
      home-manager
      aspell
      aspellDicts.en
      aspellDicts.en-computers
      aspellDicts.en-science
      nfs-utils
      unzip
      unrar
      glaze
      pkg-config
      openssl
      git
      xrandr
      vulkan-tools
      atop
      cudatoolkit
      xdg-desktop-portal-gtk
      # llm-agents.herdr
      e2fsprogs
      x11_ssh_askpass
      #system76-keyboard-configurator
    ];
  };
  programs = {
    appimage = {
      enable = true;
      binfmt = true;
    };
    steam = {
      enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];

      extraPackages = with pkgs; [
        gamescope
      ];
      extest.enable = true;
      gamescopeSession = {
        enable = true;
      };
      protontricks.enable = true;
      #remotePlay.openFirewall= true;
    };
    uwsm = {
      enable = true;
      waylandCompositors = {
        #sway = {
        #          prettyName = "Sway";
        #          comment = "Sway compositor managed by UWSM";
        #          binPath = "${pkgsUnstable.sway}/bin/sway";
        #        };
        # hyprland = {
        #   prettyName = "Hyprland";
        #   comment = "Hyprland compositor managed by UWSM";
        #   binPath = "/run/current-system/sw/bin/Hyprland";
        # };
      };
    };
  };
}
