{lib, ...}: {
  stylix.targets.foot = {
    enable = true;
    opacity = {
      enable = true;
    };
  };
  stylix.targets.neovim.transparentBackground.main = true;
  stylix.targets.nvf.transparentBackground = {
    main = true;
  };
  programs.foot = {
    server = {
      enable = true;
    };
    enable = true;
    # https://man.archlinux.org/man/foot.ini.5
    settings = {
      main = {
        dpi-aware = lib.mkForce "yes";
        bold-text-in-bright = "yes";
      };
      bell = {
        urgent = "yes";
      };
      scrollback = {
        lines = 10000;
      };
      colors-dark = {
        alpha = lib.mkForce 0.95;
      };
      cursor = {
        style = "beam";
        blink = "yes";
      };
      url = {
        # adds steam
        regex = ''(((https?://|mailto:|steam://|ftp://|file:|ssh:|ssh://|git://|tel:|magnet:|ipfs://|ipns://|gemini://|gopher://|news:)|www.)([0-9a-zA-Z:/?#@!$&*+,;=.~_%^-]+|([]["0-9a-zA-Z:/?#@!$&'*+,;=.~_%^-]*)|[[()"0-9a-zA-Z:/?#@!$&'*+,;=.~_%^-]*]|"[][()0-9a-zA-Z:/?#@!$&'*+,;=.~_%^-]*"|'[][()0-9a-zA-Z:/?#@!$&*+,;=.~_%^-]*')+([0-9a-zA-Z/#@$&*+=~_%^-]|([]["0-9a-zA-Z:/?#@!$&'*+,;=.~_%^-]*)|[[()"0-9a-zA-Z:/?#@!$&'*+,;=.~_%^-]*]|"[][()0-9a-zA-Z:/?#@!$&'*+,;=.~_%^-]*"|'[][()0-9a-zA-Z:/?#@!$&*+,;=.~_%^-]*'))'';
      };
    };
  };
}
