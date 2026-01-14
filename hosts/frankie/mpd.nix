{ config, ... }:
let
  listenAddress = "192.168.0.201";
  musicDirectory = "/storage/music/root";
in
{
  imports = [
    ../../env/email.nix
  ];
  services = {
    mpdscribble = {
      enable = true;
      host = listenAddress;
      endpoints = {
        "last.fm" = {
          passwordFile = "/run/secrets/lastfm";
          username = config.accounts.email.accounts.default.address;
        };
      };
    };
    mpd-discord-rpc.enable = true;
    mpdris2 = {
      enable = true;
      mpd = {
        host = listenAddress;
        musicDirectory = musicDirectory;
      };
    };
    listenbrainz-mpd = {
      enable = true;
      settings = {
        submission = {
          token_file = "/run/secrets/listenbrainz_token";
        };
        mpd = {
          address = listenAddress;
        };
      };
    };
  };
}
