build_host := "frankie.roto.lol"

# The desktop session exports an empty SSH_ASKPASS, which makes ssh try to
# exec a nonexistent helper whenever it needs to prompt. Never use askpass;
# prompt on the terminal (or authenticate via the agent) instead.
export SSH_ASKPASS_REQUIRE := "never"

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

rupert:
    nixos-rebuild boot --flake .#rupert --build-host {{ build_host }} --target-host rupert.roto.lol --sudo --ask-sudo-password --max-jobs 2 --cores 6

all: frankie winnie rupert phyllis
