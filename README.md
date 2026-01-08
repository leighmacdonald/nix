# My nix configuration

I dont really recommend users use this repo directly. Instead you should copy/fork it and 
use it as a starting point, or just use it as a reference.

## Secrets Setup with [sops-nix](https://github.com/Mic92/sops-nix)

1. mkdir -p /etc/sops/age
2. age-keygen -o /etc/sops/age/keys.txt # Generate a private key

## Raspberry-pi 4 Host Setup

1. Build a sdcard image: ./build_sdimage.sh <hostname>
2. Write latest aarch64-linux image to sdcard.
3. Boot and set password.
4. Import /etc/sops/age/keys.txt
5. Make initial deployment with built in `nixos` user:

   nixos-anywhere switch --flake .#CHANGEME --disko-mode mount --extra-files fakeroot/ --target-host nixos@ip-addr

6. Make further changes with your `username` instead of nixos. Note the use of --no-reexec specifically when deploying to a p.  

   nixos-rebuild boot --no-reexec --flake .#phyllis --target-host 192.168.0.211 --sudo
