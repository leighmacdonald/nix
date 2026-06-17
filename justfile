build_host := "frankie.roto.lol"

diff:
    nvd diff /run/current-system ./result
    nix store diff-closures /var/run/current-system ./result

update:
    nix flake update && nix flake archive
    git diff --name-only --exit-code flake.lock || git add flake.lock && git commit -m "System update ({{ datetime("%c") }})"

frankie: update
    nixos-rebuild build --flake .#frankie
    just --justfile {{ justfile() }} diff
    nixos-rebuild switch --flake .#frankie --build-host {{ build_host }} --target-host "frankie.roto.lol" --sudo

winnie:
    nixos-rebuild switch --flake .#winnie --build-host {{ build_host }} --target-host "winnie.roto.lol" --sudo

rupert:
    nixos-rebuild switch --flake .#rupert --build-host {{ build_host }} --target-host "rupert.roto.lol" --sudo

phyllis:
    nixos-rebuild switch --flake .#phyllis --build-host {{ build_host }} --target-host "phyllis.roto.lol" --sudo
