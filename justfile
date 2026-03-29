update:
    nix flake update && nix flake archive
    just update_host host="frankie"

update_host host="frankie":
    nixos-rebuild switch --flake .#{{ host }} --sudo
