{
  stylix.targets.qutebrowser.colors.enable = true;
  programs.qutebrowser = {
    enable = true;
    searchEngines = {
      g = "https://www.google.com/search?hl=en&amp;q={}";
    };
    settings = {
      editor.command = ["nvim" "-f" "{file}" "-c" "normal {line}G{column0}l"];
      auto_save.session = true;
      colors = {
        webpage.darkmode.enabled = true;
      };
    };
  };
}
