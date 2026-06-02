{
  pkgs,
  ...
}:
{
  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
  networking.firewall.allowedUDPPorts = [
    80
    443
  ];
  systemd.services.caddy = {
    serviceConfig.EnvironmentFile = [
      "/etc/caddy/envfile"
    ];
  };
  sops.secrets."caddy_cf_env" = {
    path = "/etc/caddy/envfile";
  };
  services.caddy = {
    enable = true;
    environmentFile = "/etc/caddy/envfile";

    email = "leigh.macdonald@gmail.com";
    virtualHosts = {
      "bt.roto.lol" = {
        extraConfig = ''
          reverse_proxy /* rupert.roto.lol:8080 {
              header_up Host {host}
              header_up X-Real-IP {remote_host}
          }
          log {
              output stdout
          }
          tls {
              dns cloudflare {$API_KEY}
          }
        '';
      };
      "gbans.roto.lol" = {
        extraConfig = ''
          @cloudflare {
              remote_ip 173.245.48.0/20 103.21.244.0/22 103.22.200.0/22 103.31.4.0/22 141.101.64.0/18 108.162.192.0/18 190.93.240.0/20 188.114.96.0/20 197.234.240.0/22 198.41.128.0/17 162.158.0.0/15 104.16.0.0/13 104.24.0.0/14 172.64.0.0/13 131.0.72.0/22 2400:cb00::/32 2606:4700::/32 2803:f800::/32 2405:b500::/32 2405:8100::/32 2a06:98c0::/29 2c0f:f248::/32
          }

          handle @cloudflare {
            reverse_proxy /* frankie.roto.lol:6007 {
              header_up Host {host}
              header_up X-Real-IP {remote_host}
              header_up X-Forwarded-For {http.request.header.CF-Connecting-IP}
            }
            log {
              output stdout
            }
            tls {
              dns cloudflare {$API_KEY}
            }
          }
          handle {
              respond "Access Denied" 403
          }
        '';
      };
      "radarr.roto.lol" = {
        extraConfig = ''
          reverse_proxy /* rupert.roto.lol:7878 {
              header_up Host {host}
              header_up X-Real-IP {remote_host}
          }
          log {
              output stdout
          }
          tls {
              dns cloudflare {$API_KEY}
          }
        '';
      };
      "cache.roto.lol" = {
        extraConfig = ''
          reverse_proxy /* rupert.roto.lol:5000 {
              header_up Host {host}
              header_up X-Real-IP {remote_host}
          }
          log {
              output stdout
          }
          tls {
              dns cloudflare {$API_KEY}
          }
        '';
      };
      "lidarr.roto.lol" = {
        extraConfig = ''
          reverse_proxy /* rupert.roto.lol:8686 {
              header_up Host {host}
              header_up X-Real-IP {remote_host}
          }
          log {
              output stdout
          }
          tls {
              dns cloudflare {$API_KEY}
          }
        '';
      };
      "sonarr.roto.lol" = {
        extraConfig = ''
          reverse_proxy /* rupert.roto.lol:8989 {
              header_up Host {host}
              header_up X-Real-IP {remote_host}
          }
          log {
              output stdout
          }
          tls {
              dns cloudflare {$API_KEY}
          }
        '';
      };
      "bazarr.roto.lol" = {
        extraConfig = ''
          reverse_proxy /* rupert.roto.lol:6767 {
              header_up Host {host}
              header_up X-Real-IP {remote_host}
          }
          log {
              output stdout
          }
          tls {
              dns cloudflare {$API_KEY}
          }
        '';
      };
      "autobrr.roto.lol" = {
        extraConfig = ''
          reverse_proxy /* rupert.roto.lol:7474 {
              header_up Host {host}
              header_up X-Real-IP {remote_host}
          }
          log {
              output stdout
          }
          tls {
              dns cloudflare {$API_KEY}
          }
        '';
      };
      "prowlarr.roto.lol" = {
        extraConfig = ''
          reverse_proxy /* rupert.roto.lol:9696 {
              header_up Host {host}
              header_up X-Real-IP {remote_host}
          }
          log {
              output stdout
          }
          tls {
              dns cloudflare {$API_KEY}
          }
        '';
      };
      "overseerr.roto.lol" = {
        extraConfig = ''
          reverse_proxy /* rupert.roto.lol:5055 {
              header_up Host {host}
              header_up X-Real-IP {remote_host}
          }
          log {
              output stdout
          }
          tls {
              dns cloudflare {$API_KEY}
          }
        '';
      };
      "pgadmin.roto.lol" = {
        extraConfig = ''
          reverse_proxy /* rupert.roto.lol:5050 {
              header_up Host {host}
              header_up X-Real-IP {remote_host}
          }
          log {
              output stdout
          }
          tls {
              dns cloudflare {$API_KEY}
          }
        '';
      };
      "jellyfin.roto.lol" = {
        extraConfig = ''
          reverse_proxy /* rupert.roto.lol:8096 {
              header_up Host {host}
              header_up X-Real-IP {remote_host}
          }
          log {
              output stdout
          }
          reverse_proxy /socket/* rupert.roto.lol:8096 {
              header_up Host {host}
              header_up X-Real-IP {remote_host}
              header_up Connection {>Connection}
              header_up Upgrade {>Upgrade}
          }
          tls {
              dns cloudflare {$API_KEY}
          }
        '';
      };
    };
    package = pkgs.caddy.withPlugins {
      plugins = [ "github.com/caddy-dns/cloudflare@v0.2.2" ];
      hash = "sha256-dnhEjopeA0UiI+XVYHYpsjcEI6Y1Hacbi28hVKYQURg=";
    };
  };
}
