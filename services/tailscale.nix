{
  networking.firewall.trustedInterfaces = [ "tailscale0" ];
  services.tailscale = {
    enable = true;
    extraDaemonFlags = [ "--no-logs-no-support" ];
    authKeyFile = "/run/secrets/tskey";
  };
  # tailscaled can take a while to reach State=Running after a restart (slow
  # control-plane connectivity). The default 90s start timeout is too tight and
  # makes nixos-rebuild report a failed unit even though tailscale recovers.
  systemd.services.tailscaled-autoconnect.serviceConfig.TimeoutStartSec = "5min";
}
