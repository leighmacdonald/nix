{ pkgs, lib, ... }:
{
  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";
    imageScalingMode = "fill";
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    base16Scheme = lib.mkDefault "${pkgs.base16-schemes}/share/themes/nord.yaml";
    overlays.enable = true;
    opacity.popups = 0.8;
    homeManagerIntegration.followSystem = true;
    # override = {
    #   base00 = "11111b";
    # };
    fonts = {
      sizes = {
        applications = lib.mkDefault 16;
        terminal = lib.mkDefault 18;
        desktop = lib.mkDefault 22;
        popups = lib.mkDefault 22;
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
