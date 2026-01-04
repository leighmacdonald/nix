# My nix configuration

## Secrets Setup with [sops-nix](https://github.com/Mic92/sops-nix)

1. mkdir -p /etc/sops/age
2. age-keygen -o /etc/sops/age/keys.txt

## Raspberry-pi 4 Host Setup

1. Write latest aarch64-linux image to sdcard.
2. Boot and set password.
3. Make initial deployment with built in `nixos` user:

   nixos-anywhere switch --flake .#CHANGEME --disko-mode mount --extra-files fakeroot/ --target-host nixos@ip-addr

4. Make further changes with your `username` instead of nixos.

   nixos-anywhere switch --flake .#CHANGEME --disko-mode mount --extra-files fakeroot/ --target-host username@ip-addr
