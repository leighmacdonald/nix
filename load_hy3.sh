#!/run/current-system/sw/bin/bash
PATH="$(nix eval --raw nixpkgs#hyprlandPlugins.hy3)/lib/libhy3.so"
/run/current-system/sw/bin/hyprctl plugin load ${PATH}
