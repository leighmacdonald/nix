# { inputs, pkgs, ... }:
{
  home = {
    file = {
      # # LSP stubs for Hyprland's Lua API at a stable user path. The hyprland
      # # package's share/hypr/stubs dir changes hash on each upgrade, so we link
      # # it into ~/.local/share/hypr/stubs and reference *that* from .luarc.json.
      # # Updates automatically on rebuild.
      # ".local/share/hypr/stubs".source = "${pkgs.hyprland}/share/hypr/stubs";
      # ".wallpaper" = {
      #   source = "${inputs.self}/wallpaper";
      #   recursive = true;
      # };
    };
  };
}
