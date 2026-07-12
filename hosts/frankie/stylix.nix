{
  pkgs,
  inputs,
  ...
}:
{
  imports = [ inputs.stylix.nixosModules.stylix ];
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-dark.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/heetch.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/pandora.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/chalk.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-soft.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/phd.yaml";
    # last one
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/blueforest.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-hard.yaml";
    fonts = {
      sizes = {
        applications = 20;
        terminal = 14;
        desktop = 20;
        popups = 20;
      };
      monospace = {
        name = "TX-02";
      };
    };
  };
}
