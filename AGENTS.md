# NixOS Configuration Repo

Personal NixOS config managing 4 hosts across x86_64 and aarch64. Flake-based, sops-nix secrets, home-manager integrated per host.

## Commands

| Command | Description |
|---------|-------------|
| `just <hostname>` | Deploy to host (remote build via `frankie.roto.lol`) |
| `just update` | `nix flake update`, commit lockfile changes |
| `just diff` | Compare built result vs running system |
| `./build_sdimage.sh <hostname>` | Build SD card image for RPi4 hosts |
| `just build_host=... <target>` | Override remote build host |

## Architecture

- **flake.nix** — entrypoint; defines all `nixosConfigurations`
- **hosts/<name>/default.nix** — per-host config, imports shared modules from `../..`
- **modules/** — shared NixOS modules (nix, fonts, secrets, stylix, nvidia, etc.)
- **programs/** — shared program configs; `neovim/` is a subdirectory with 39 files
- **services/** — shared service definitions (docker, tailscale, openssh, etc.)
- **users/** — user definitions (`leigh.nix`, `root.nix`)
- **env/** — locale, console, service toggles, no-sudo-pass
- **platform/rpi4/** — Raspberry Pi 4 platform module
- **secrets/** — sops-nix encrypted secrets
- **fakeroot/** — extra files for `nixos-anywhere` initial deployment

## Hosts

| Host | Arch | Notes |
|------|------|-------|
| frankie | x86_64 | Main desktop, NVIDIA, Hyprland, LLM tools, llm-agents overlay, unstable pkgs |
| winnie | aarch64 | RPi4, disko for disk layout |
| rupert | x86_64 | Secondary host |
| phyllis | aarch64 | RPi4 |

## Flake inputs

nixpkgs `nixos-26.05` + `nixpkgs-unstable`, home-manager/stylix `release-26.05`, plus sops-nix, disko, impermanence, nixcord, nvf, llm-agents, nixos-hardware.

## Secrets (sops-nix)

Age keys in `.sops.yaml` for admin + 5 servers. Per-host encrypted secrets at `hosts/<name>/secrets.nix`. Private key (`keys.txt`, gitignored) must be placed at `fakeroot/etc/sops/age/keys.txt` for initial deploy.

## Gotchas

- **frankie's home-manager** is structured differently — no `useGlobalPkgs`/`useUserPackages`, uses llm-agents overlay and unstable pkgs
- **RPi4 hosts** require `--no-reexec` on `nixos-rebuild`
- **Initial deploy** uses `nixos-anywhere` with `fakeroot/` extra files; fix permissions after first boot: `sudo chown $USER:lusers /home/$USER /home/$USER/.ssh`
- **direnv** — run `direnv allow` on first use (`.envrc` loads nix)
- **vllm** — frankie has `permittedInsecurePackages` for `python3.14-vllm`
