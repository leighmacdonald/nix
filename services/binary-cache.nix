{
  services.nix-serve = {
    enable = true;
    openFirewall = true;
    secretKeyFile = "/var/secrets/cache-private-key.pem";
  };
}
