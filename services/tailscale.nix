{
  networking.firewall.trustedInterfaces = [ "tailscale0" ];
  services.tailscale = {
    enable = true;
    extraDaemonFlags = [ "--no-logs-no-support" ];
    authKeyFile = "/run/secrets/tskey";
  };
}
