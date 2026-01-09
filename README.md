# My nix configuration

I dont really recommend users use this repo directly. Instead you should copy/fork it and
use it as a starting point, or just use it as a reference.

## Deploy to remote host

1. Boot installation media, set a ssh password.
2. Copy your sops keys.txt to fakeroot/etc/sops/age/keys.txt
3. Deploy with `sudo nixos-anywhere --flake .#frankie --target-host nixos@1.2.3.4 --extra-files fakeroot/ --build-on remote`
4. Some permissions are incorrect set currently, so upon login `sudo chown $username:lusers /home/$username /home/$username/.ssh`

If you need access to nixos-anywhere or the other tools, assuming you have nix installed somewhere, you can use the `shell.nix` by running `nix-shell` in this repo.

```nix
{
  pkgs ? import <nixpkgs> { },
}:
pkgs.mkShell {
  packages = with pkgs; [
    git
    npins
    nixos-anywhere
    nixos-rebuild
    ssh-to-age
    age
  ];
}
```

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
