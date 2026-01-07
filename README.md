# My nix configuration

## Secrets Setup with [sops-nix](https://github.com/Mic92/sops-nix)

1. mkdir -p /etc/sops/age
2. age-keygen -o /etc/sops/age/keys.txt

## Raspberry-pi 4 Host Setup

1. Build a sdcard image: ./build_sdimage.sh <hostname>
2. Write latest aarch64-linux image to sdcard.
3. Boot and set password.
4. Make initial deployment with built in `nixos` user:

   nixos-anywhere switch --flake .#CHANGEME --disko-mode mount --extra-files fakeroot/ --target-host nixos@ip-addr

5. Make further changes with your `username` instead of nixos.

   nixos-anywhere switch --flake .#CHANGEME --disko-mode mount --extra-files fakeroot/ --target-host username@ip-addr
