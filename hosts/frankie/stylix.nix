{
  pkgs,
  inputs,
  ...
}:
{
  imports = [ inputs.stylix.nixosModules.stylix ];
  stylix = {
    enable = true;
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest-dark-hard.yaml";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/phd.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-hard.yaml";
    #
    fonts = {
      sizes = {
        applications = 16;
        terminal = 14;
        desktop = 20;
        popups = 18;
      };
    };
  };
}
