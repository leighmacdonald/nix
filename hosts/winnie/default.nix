{
  imports = [
    ./programs.nix

    ../../platform/rpi4

    ../../env/locale.nix
    ../../env/console.nix
    ../../env/disable_services.nix
    ../../env/no-sudo-pass.nix

    ../../users/leigh.nix
    ../../users/root.nix

    ../../modules/secrets.nix
    ../../modules/documentation.nix
    ../../modules/wifi.nix
    ../../modules/nix.nix

    # NOTE: public ingress moved to the Cloudflare Tunnel on rupert
    # (hosts/rupert/cloudflared.nix); Caddy and ddns-updater were removed.
    # Tunnel CNAMEs are static, so no dynamic DNS updates are needed.
    ../../services/openssh.nix
    ../../services/tailscale.nix
  ];

  # NOTE: ports 80/443 used to be opened here for Caddy, which has been
  # replaced by the Cloudflare Tunnel on rupert. The tunnel needs no
  # inbound ports, so nothing is opened.

  documentation.enable = false;
}
