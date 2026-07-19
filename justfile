build_host := "frankie.roto.lol"

diff:
    nvd diff /run/current-system ./result
    nix store diff-closures /var/run/current-system ./result

update:
    nix flake update && nix flake archive
    git diff --name-only --exit-code flake.lock || git add flake.lock && git commit -m "System update ({{ datetime("%c") }})"

frankie:
    # nixos-rebuild build --flake .#frankie
    # just --justfile {{ justfile() }} diff
    nixos-rebuild switch --flake .#frankie --build-host {{ build_host }} --target-host frankie.roto.lol --sudo

winnie:
    nixos-rebuild boot --flake .#winnie --build-host {{ build_host }} --target-host winnie.roto.lol --sudo
    ssh winnie.roto.lol sudo reboot

rupert:
    nixos-rebuild boot --flake .#rupert --build-host {{ build_host }} --target-host rupert.roto.lol --sudo --ask-sudo-password
    ssh rupert.roto.lol sudo reboot 

phyllis:
    nixos-rebuild boot --flake .#phyllis --build-host {{ build_host }} --target-host 192.168.0.100 --sudo

all: frankie winnie rupert phyllis
