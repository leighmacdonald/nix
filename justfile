build_host := "frankie.roto.lol"

update:
    nix flake update && nix flake archive

frankie:
    nixos-rebuild switch --flake .#frankie --build-host {{ build_host }} --target-host "frankie.roto.lol" --sudo

winnie:
    nixos-rebuild switch --flake .#winnie --build-host {{ build_host }} --target-host "winnie.roto.lol" --sudo

rupert:
    nixos-rebuild switch --flake .#rupert --build-host {{ build_host }} --target-host "rupert.roto.lol" --sudo

phyllis:
    nixos-rebuild switch --flake .#phyllis --build-host {{ build_host }} --target-host "phyllis.roto.lol" --sudo
