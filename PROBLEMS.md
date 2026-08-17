# Problems

Audit of the NixOS config repo (as of 2026-07-31). Grouped by severity; all paths relative to repo root.

## Critical security

1. **Admin age private key world-readable** — `keys.txt` (the sops identity) sits at the repo root as `-rwxrwxrwx root:root` (mode `777`, owned by root). It is gitignored and never committed, but its on-disk permissions are wrong and it is exposed to every local user. Fix: `chmod 600 keys.txt` and `chown` to yourself; consider moving it out of the repo dir entirely (e.g. `~/.config/sops/age/keys.txt`).

2. **Unauthenticated opencode web server with full auto-exec** — `hosts/frankie/opencode.nix:31` binds `0.0.0.0:8090` and `permission."*" = "allow"` (`opencode.nix:119`); the firewall opens 8090 (`hosts/frankie/network.nix:42`). Any LAN device can reach `frankie:8090` directly, bypassing the `basic_auth` that only protects `oc.roto.lol` through caddy (`winnie/caddy.nix:111`). This yields an unauthenticated agent with bash/edit permission on the desktop. Bind to 127.0.0.1 (or the tailnet) and require auth.

3. **Entire `-arr` stack publicly exposed with no auth** — caddy on winnie reverse-proxies `radarr/sonarr/lidarr/prowlarr/bazarr/autobrr/overseerr/pgadmin/jellyfin/bt(qbittorrent).roto.lol` to rupert with zero authentication (`winnie/caddy.nix:67-244`). `pgadmin.roto.lol` in particular puts a DB admin UI on the public internet. Only `oc.roto.lol` and `gbans.roto.lol` have any protection. Add `basic_auth`/`forward_auth`/Cloudflare-only filters per vhost.

4. **Postgres trusts everything on localhost** — `hosts/rupert/postgres.nix:50-62`: `local all all trust` and `host all all 127.0.0.1/32 trust` appear before the `scram-sha-256` lines, so those scram rules are dead (first-match wins). Any local user can connect as any role without a password. `leigh` is also `superuser` (`postgres.nix:99`), and port 5432 is firewall-opened on both rupert (`postgres.nix:10`) and frankie (`hosts/frankie/network.nix:36`; frankie runs no postgres service at all).

5. **qBittorrent WebUI hash hardcoded in the repo** — `hosts/rupert/qbittorrent.nix:88` commits the PBKDF2 password hash in plain git, and `bt.roto.lol` is publicly exposed. The postgres SCRAM hashes are likewise committed in `hosts/rupert/postgres.nix:64-91` (offline-crackable; should live in sops).

6. **Sops secrets with world-writable modes** — `autobrr_session_key` mode `666` (`hosts/rupert/autobrr.nix:5`), `beets.yaml` mode `777` (`hosts/rupert/secrets.nix:25`), `ddns-updater.conf` mode `666` (`services/ddns-updater.nix:5`), WiFi PSK secret `wireless.conf` mode `775` (`modules/wifi.nix:5`), and the `*_env` files mode `666` (`hosts/rupert/secrets.nix:4`). These should be `600`/`640` with explicit owners/groups.

## High

7. **Passwordless sudo on every host including the media server** — `env/no-sudo-pass.nix` (`wheelNeedsPassword = false`) is imported by rupert, which runs the whole `-arr` stack as `leigh` (`sonarr.nix:9`, `radarr.nix:9`, `lidarr.nix:9`, `qbittorrent.nix:29`, `jellyfin.nix:6`). Those apps process untrusted content; a compromise = root. Use dedicated service users, and reconsider passwordless wheel on hosts ingesting untrusted data.

8. **`-arr`/jellyfin/beets web UIs exposed on the LAN with no auth** — `openFirewall = true` on every service; beets exposes a writable web API (`hosts/rupert/beets.nix:85-89`, port 8337), opened in `hosts/rupert/default.nix:163-172`.

9. **llama-server on `0.0.0.0:8081` with no auth** — `hosts/frankie/llama-cpp.nix:24` (`--host 0.0.0.0`), firewall-opened and publicly proxied via `autocomplete.roto.lol`. The `autocomplete` systemd unit is also defined with `enable = false` (`llama-cpp.nix:17`) — dead config.

10. **NFS without security** — `hosts/rupert/default.nix:76-80` exports `/export` `rw,insecure` to the whole `192.168.0.0/24`; frankie/phyllis mount it `async` (`fs/nfs-mounts.nix:10`). Anyone on the LAN can read/write music/media/backups.

11. **mpd unauthenticated on `0.0.0.0:6600`** — `services/mpd.nix:31-32`; frankie proxies its mpd to rupert:6600. No password configured.

12. **node_exporter open on the LAN** — `services/node_exporter.nix:2`, with full collectors incl. `sysctl`, `cpu_vulnerabilities`, `dmi`, `systemd`.

13. **LLM tooling runs with `*`-allow tool permissions** — zed `tool_permissions.default = "allow"` + terminal allowed (`programs/zed.nix:116-138`) and opencode `*` allow, all pointed at local models on the LAN-facing llama-swap. High blast radius if a model is prompted maliciously.

14. **Rupert has no disk encryption** — plain btrfs (`hosts/rupert/disk-config.nix`), unlike frankie's LUKS setup.

## Correctness bugs

15. **`/nix` subvol mounted as `subvol=home`** — `hosts/rupert/disk-config.nix:63-70` mounts the nix store on the `home` subvol. Almost certainly a bug; should be `subvol=nix`.

16. **Copy-paste bug in prowlarr** — `hosts/rupert/prowlarr.nix:2-4` adds `systemd.services.sonarr.requires` instead of `prowlarr`.

17. **`ddns-updater.conf` secret missing from `secrets.yaml`** — referenced at `services/ddns-updater.nix:14` but absent from the sops file (all other referenced secrets exist). The ddns-updater service cannot start.

18. **MPD socket inconsistency** — frankie's mpd listens on a unix socket only, but `mpd-discord-rpc` is also told to use `192.168.0.200:6600` (`hosts/frankie/mpd.nix:2,42-44`).

19. **phyllis DHCP vs static IP conflict** — `platform/rpi4/network.nix:10` sets `useDHCP = true` on `end0` while `hosts/phyllis/default.nix:13-30` assigns a static address to the same interface.

20. **Postgres "trust before scram" ordering** — the auth rules in `hosts/rupert/postgres.nix:50-62` make the scram lines dead (see #4).

21. **Sway output keys mixed** — `pos` on DP-1/HDMI-A-1 but `position` on DP-2/DP-3 (`programs/sway.nix:114-137`); only one is valid for the home-manager sway module.

22. **Typos** — `UpdateBiaryPath` (`programs/keepassxc.nix:25`, also `hosts/phyllis/home.nix`), `NVD_BACKEN` (`hosts/frankie/home.nix:154`), `Defaults:picloud` references a non-existent user (`modules/sudo.nix:22`; that module is also unused).

23. **`discord-mpd.sh`** references `$ARTIST`/`$TITLE`, which are never set in the script.

24. **`load_hy3.sh`** overwrites `PATH` with a plugin path — the `PATH=` assignment is nonsense.

25. **`shell.nix`/`.envrc` depend on `import <nixpkgs>`** — breaks without a NIX_PATH channel, atypical for a flake repo.

26. **Frankie firewall opens 5432/5445 with no postgres service**; ports 6006/6007 are also LAN-open while caddy restricts `gbans.roto.lol` to Cloudflare IPs only.

## Consistency / DRY / best practice

27. **Home-manager wired up three different ways** — flake-level module for phyllis/winnie/rupert, host-level import for frankie; frankie's `home-manager.nix` actually does use `useGlobalPkgs`/`useUserPackages`, so the AGENTS.md gotcha is stale.

28. **stylix configured/imported in three places** — flake module + `modules/stylix.nix` + `hosts/frankie/stylix.nix`, with frankie importing two of them at once (duplicate/conflicting base16 config).

29. **Duplicate app configs** — keepassxc (programs/ + phyllis inline), firefox (programs/ + phyllis inline), sway (programs/ + phyllis inline), full firefox extension list duplicated between frankie and phyllis.

30. **Duplicate packages** — `wttrbar` ×2 and `sqlite` ×2 (`hosts/frankie/home.nix:103/120, 132/138`); `biome`, `clang-tools`, `nixfmt`, `buf` ×2 (`hosts/frankie/opencode.nix:42-86`); `flameshot`/`bat` both as package and module.

31. **`documentation.nix` vs `nodocumentation.nix`** — two files that could be one module with a toggle.

32. **Hardcoded `leigh`/`lusers`/absolute paths** instead of `username`/`config.home` — `users.users.leigh` (`hosts/frankie/virt.nix:7`), `home-manager-leigh` (`hosts/frankie/persistence.nix:7`), `/home/leigh/...` (`programs/vscode.nix`, `programs/zed.nix`).

33. **Firewall rules duplicated across files** — ports repeated in `hosts/frankie/network.nix`, `hosts/rupert/default.nix`, `services/node_exporter.nix`, `platform/rpi4/network.nix`; frankie's uinput setup is triplicated (`hardware.uinput` + manual udev rule + ydotool group).

34. **`permittedInsecurePackages` with a `# TODO remove`** left in `hosts/frankie/default.nix:58-62` (incl. `pnpm-9.15.9`).

35. **No flake host abstraction** — four near-identical `nixosSystem` blocks in `flake.nix` (a `hostName`-based helper already exists, commented out). A `mkHost` helper would remove the copy-paste.

36. **Nameservers hardcoded** to 8.8.8.8/9.9.9.9 on frankie (no DoT, no local DNS).

## Dead code / cruft

37. **Files never imported**: `modules/zram.nix`, `modules/sudo.nix`, `programs/foot.nix`, `programs/mcp.nix`, `programs/uwsm.nix`, `services/grafana.nix`, `services/binary-cache-client.nix`, `platform/rpi4/disk.nix`, `hosts/frankie/steam.nix` (whole file commented out).

38. **Stubs and commented-out cruft** — `flake.nix` carries ~50 lines of commented-out `mika`/`frankieiso` hosts and a `stylix` `follows` comment; `services/binary-cache.nix` is an `enable = false` stub; `modules/sudo.nix` is unused; `hosts/frankie/llama-cpp.nix` has a dead `systemd.services.autocomplete`, a commented Dockerfile/activation hack, and a `llama-swap` EnvironmentFile override (`:66-68`) that likely collides with the module's own setting.

39. **Unused sops secrets** — `hostkey_mika_ed25519*`, `local_cache*`, `hostkey_*_pub` exist in `secrets/secrets.yaml` but are never referenced anywhere in the config.
