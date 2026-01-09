{pkgs, ...}: {
  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";
    imageScalingMode = "fill";
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
    overlays.enable = true;
    opacity.popups = 0.8;
    # override = {
    #   base00 = "11111b";
    # };
    fonts = {
      sizes = {
        applications = 16;
        terminal = 18;
        desktop = 22;
        popups = 22;
      };
      #            serif = {
      #                package = pkgs.dejavu_fonts;
      #                name = "DejaVu Serif";
      #            };
      #
      #            sansSerif = {
      #                package = pkgs.dejavu_fonts;
      #                name = "DejaVu Sans";
      #           };
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };
    targets = {
      #qt.standardDialogs = "xdgdesktopportal";
      font-packages = {
        enable = true;
      };
      nvf.enable = true;
      fontconfig.fonts = {
        enable = true;
      };
    };
  };
}
