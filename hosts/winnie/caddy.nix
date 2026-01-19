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
    #dataDir = "/backup/config/caddy";
    # acme_ca = "https://acme-v02.api.letsencrypt.org/directory";
    #acmeCA = "https://acme.zerossl.com/v2/DV90";
    environmentFile = "/etc/caddy/envfile";
    email = "leigh.macdonald@gmail.com";
    virtualHosts = {
      "bt.roto.lol" = {
        extraConfig = ''
          reverse_proxy /* rupert.roto.lol:8080 {
              header_up Host {host}
              header_up X-Real-IP {remote_host}
          }
          import rotolol
        '';
      };
      "radarr.roto.lol" = {
        extraConfig = ''
          reverse_proxy /* rupert.roto.lol:7878 {
              header_up Host {host}
              header_up X-Real-IP {remote_host}
          }
          import rotolol
        '';
      };
      "cache.roto.lol" = {
        extraConfig = ''
          reverse_proxy /* rupert.roto.lol:5000 {
              header_up Host {host}
              header_up X-Real-IP {remote_host}
          }
          import rotolol
        '';
      };
      "lidarr.roto.lol" = {
        extraConfig = ''
          reverse_proxy /* rupert.roto.lol:8686 {
              header_up Host {host}
              header_up X-Real-IP {remote_host}
          }
          import rotolol
        '';
      };
      "sonarr.roto.lol" = {
        extraConfig = ''
          reverse_proxy /* rupert.roto.lol:8989 {
              header_up Host {host}
              header_up X-Real-IP {remote_host}
          }
          import rotolol
        '';
      };
      "bazarr.roto.lol" = {
        extraConfig = ''
          reverse_proxy /* rupert.roto.lol:6767 {
              header_up Host {host}
              header_up X-Real-IP {remote_host}
          }
          import rotolol
        '';
      };
      "autobrr.roto.lol" = {
        extraConfig = ''
          reverse_proxy /* rupert.roto.lol:7474 {
              header_up Host {host}
              header_up X-Real-IP {remote_host}
          }
          import rotolol
        '';
      };
      "prowlarr.roto.lol" = {
        extraConfig = ''
          reverse_proxy /* rupert.roto.lol:9696 {
              header_up Host {host}
              header_up X-Real-IP {remote_host}
          }
          import rotolol
        '';
      };
      "overseerr.roto.lol" = {
        extraConfig = ''
          reverse_proxy /* rupert.roto.lol:5055 {
              header_up Host {host}
              header_up X-Real-IP {remote_host}
          }
          import rotolol
        '';
      };
      "jellyfin.roto.lol" = {
        extraConfig = ''
          reverse_proxy /* rupert.roto.lol:8096 {
              header_up Host {host}
              header_up X-Real-IP {remote_host}
          }
          reverse_proxy /socket/* rupert.roto.lol:8096 {
              header_up Host {host}
              header_up X-Real-IP {remote_host}
              header_up Connection {>Connection}
              header_up Upgrade {>Upgrade}
          }
          import rotolol
        '';
      };
    };

    extraConfig = ''
      (rotolol) {
          tls {
              dns cloudflare {$API_KEY}
          }
      }
    '';
    package = pkgs.caddy.withPlugins {
      plugins = [ "github.com/caddy-dns/cloudflare@v0.2.2" ];
      hash = "sha256-dnhEjopeA0UiI+XVYHYpsjcEI6Y1Hacbi28hVKYQURg=";
    };
  };
}
