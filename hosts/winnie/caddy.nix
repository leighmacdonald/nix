{
  pkgs,
  config,
  ...
}: {
  networking.firewall.allowedTCPPorts = [80 443];
  systemd.services.caddy = {
    serviceConfig.EnvironmentFile = [
      "/etc/caddy/envfile"
    ];
  };
  sops.secrets."caddy_cf_env" = {
    owner = "caddy";
    mode = "0600";
  };
  services.caddy = {
    enable = true;
    #acme_ca = "https://acme.zerossl.com/v2/DV90";
    email = "leigh.macdonald@gmail.com";
    globalConfig = ''
      (rotolol) {
          tls {
              dns cloudflare {$API_KEY}
          }
      }
    '';
    package = pkgs.caddy.withPlugins {
      plugins = ["github.com/caddy-dns/cloudflare@v0.2.2"];
      hash = "sha256-dnhEjopeA0UiI+XVYHYpsjcEI6Y1Hacbi28hVKYQURg=";
    };
  };
}
